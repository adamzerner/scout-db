class TournamentsController < ApplicationController
  before_action :authorize_user, except: [:index, :show]
  helper_method :sort_column, :sort_direction, :filter_params

  def index
    @filter_options = Tournament.filter_options
    @filters_to_apply = filter_params && !filter_params.empty?
    @tournaments = Tournament.sorted_tournaments(sort_column, sort_direction)
    @tournaments = @filters_to_apply ? get_filtered_tournaments(@tournaments, filter_params) : @tournaments
  end

  def show
    @tournament = Tournament.find(params[:id])
    @filter_options = @tournament.filter_options(current_user)
    @filters_to_apply = filter_params && !filter_params.empty?
    @games = @tournament.sorted_games(sort_column, sort_direction)
    @games = @filters_to_apply ? get_filtered_games(@games, filter_params) : @games
  end

  def new
    @tournament = Tournament.new
    @tournament.tournament_director = TournamentDirector.new
    @tournament.tournament_director.address = Address.new
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
        .permit(:name,
          tournament_director_attributes: [:first_name, :middle_name, :last_name, :email, :phone_number, address_attributes: [ :id, :line_one, :line_two, :city, :state, :zip ]],
          games_attributes: [:id, :_destroy, :team_one_id, :team_two_id, :field_id, :date, :start_time]
        )
    end

    def sort_column
      if params[:action] === "index"
        return %w[name dates location].include?(params[:sort]) ? params[:sort] : "name"
      elsif params[:action] === "show"
        return %w[id team_one team_two date start_time field].include?(params[:sort]) ? params[:sort] : "date"
      end
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end

    def filter_params
      params.permit(:sort, :direction, :earliest_start_date, :latest_start_date, :earliest_start_time, :latest_start_time, :commit, :id, location_filters: [], player_list_filters: [], player_filters: [], team_filters: [], date_filters: [], field_filters: []).except(:id, :commit, :sort, :direction)
    end

    def get_filtered_tournaments(tournaments, filters)
      return tournaments.filter do |tournament|
        tournament.passes_through_filters(filters)
      end
    end

    def get_filtered_games(games, filters)
      return games.filter do |game|
        game.passes_through_filters(filters)
      end
    end
end
