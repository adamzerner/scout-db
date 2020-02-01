class TournamentsController < ApplicationController
  before_action :authorize_user, except: [:index, :show]
  helper_method :sort_column, :sort_direction, :filter_params

  def index
    @tournaments = Tournament.all
  end

  def show
    @tournament = Tournament.find(params[:id])
    @filter_options = @tournament.filter_options
    @filters_to_apply = filter_params && !filter_params.empty?
    @games = @tournament.sorted_games(sort_column, sort_direction)
    @games = @filters_to_apply ? get_filtered_games(@games, filter_params) : @games
  end

  def new
    @tournament = Tournament.new
  end

  def create
    @tournament = Tournament.new(tournament_params)

    if @tournament.save
      redirect_to @tournament
    else
      @tournament.errors.full_messages.each do |message|
        puts message
      end
      render 'new'
    end
  end

  def edit
    @tournament = Tournament.find(params[:id])
  end

  def update
    @tournament = Tournament.find(params[:id])

    if @tournament.update(tournament_params)
      redirect_to @tournament
    else
      render 'edit'
    end
  end

  def destroy
    @tournament = Tournament.find(params[:id])
    @tournament.destroy

    redirect_to tournaments_path
  end

  private
    def tournament_params
      params
        .require(:tournament)
        .permit(:name, games_attributes: [:id, :_destroy, :team_one_id, :team_two_id, :field_id, :date, :start_time])
    end

    def sort_column
      %w[id team_one team_two date start_time field].include?(params[:sort]) ? params[:sort] : "date"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end

    def filter_params
      params.permit(:sort, :direction, :earliest_start_time, :latest_start_time, :commit, :id, player_filters: [], team_filters: [], date_filters: [], field_filters: []).except(:id, :commit, :sort, :direction)
    end

    def get_filtered_games(games, filters)
      return games.filter do |game|
        game.passes_through_filters(filters)
      end
    end
end
