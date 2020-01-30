class TournamentsController < ApplicationController
  helper_method :sort_column, :sort_direction

  def index
    @tournaments = Tournament.all
  end

  def show
    @tournament = Tournament.find(params[:id])

    if sort_column === "team_one"
      @games = @tournament.games.sort do |a, b|
        a.team_one.name <=> b.team_one.name
      end
      @games.reverse! if sort_direction === "desc"
    elsif sort_column === "team_two"
      @games = @tournament.games.sort do |a, b|
        a.team_two.name <=> b.team_two.name
      end
      @games.reverse! if sort_direction === "desc"
    elsif sort_column === "field"
      @games = @tournament.games.left_joins(:field).order("fields.name #{sort_direction}")
    else
      @games = @tournament.games.order("#{sort_column} #{sort_direction}")
    end

    @filter_options = @tournament.filter_options
    @filters_to_apply = filter_params && !filter_params.empty?

    if @filters_to_apply
      @games = get_filtered_games(@games, filter_params)
    end
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
      result = params
        .require(:tournament)
        .permit(:name, games_attributes: [:id, :_destroy, :team_one_id, :team_two_id, :field_id, :date, :start_time])
      add_team_types(result)

      return result
    end

    def add_team_types(tournament_params)
      tournament_params[:games_attributes].each do |game_id, game_attributes|
        if game_attributes[:team_one_id].include?("high-school-team")
          game_attributes[:team_one_id] = game_attributes[:team_one_id].split(':').last
          game_attributes[:team_one_type] = "HighSchoolTeam"
        elsif game_attributes[:team_one_id].include?("club-team")
          game_attributes[:team_one_id] = game_attributes[:team_one_id].split(':').last
          game_attributes[:team_one_type] = "ClubTeam"
        end

        if game_attributes[:team_two_id].include?("high-school-team")
          game_attributes[:team_two_id] = game_attributes[:team_two_id].split(':').last
          game_attributes[:team_two_type] = "HighSchoolTeam"
        elsif game_attributes[:team_two_id].include?("club-team")
          game_attributes[:team_two_id] = game_attributes[:team_two_id].split(':').last
          game_attributes[:team_two_type] = "ClubTeam"
        end
      end
    end

    def sort_column
      %w[id team_one team_two date start_time field].include?(params[:sort]) ? params[:sort] : "date"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end

    def filter_params
      params.permit(:earliest_start_time, :latest_start_time, :commit, :id, player_filters: [], team_filters: [], date_filters: [], field_filters: []).except(:id, :commit)
    end

    def get_filtered_games(games, filters)
      return games.filter do |game|
        game.passes_through_filters(filters)
      end
    end
end
