class ClubTeamsController < ApplicationController
  before_action :authorize_user, except: [:index, :show]
  helper_method :sort_column, :filter_params

  def index
    index_of_first_club_team = (page * ClubTeam.ITEMS_PER_PAGE) - ClubTeam.ITEMS_PER_PAGE
    index_of_last_club_team = page * ClubTeam.ITEMS_PER_PAGE

    @club_teams = ClubTeam.sorted_club_teams(sort_column, sort_direction)
    @curr_page = page
    @club_teams = @club_teams[index_of_first_club_team...index_of_last_club_team]
  end

  def show
    @club_team = ClubTeam.find(params[:id])
    @filter_options = Player.filter_options(@club_team.players)
    @filters_to_apply = players_table_filter_params && !players_table_filter_params.empty?
    @players = Player.sorted_players(players_table_sort_column, sort_direction, @club_team.players)
    @players = @filters_to_apply ? get_filtered_players(@players, players_table_filter_params) : @players
  end

  def new
    @club_team = ClubTeam.new
    @club_team.coach = Coach.new
    @club_team.manager = Manager.new
  end

  def edit
    @club_team = ClubTeam.find(params[:id])
  end

  def create
    @club_team = ClubTeam.new(club_team_params)

    if @club_team.save
      redirect_to @club_team
    else
      render 'new'
    end
  end

  def update
    @club_team = ClubTeam.find(params[:id])

    if @club_team.update(club_team_params)
      redirect_to @club_team
    else
      render 'edit'
    end
  end

  def destroy
    @club_team = ClubTeam.find(params[:id])
    @club_team.destroy

    redirect_to club_teams_path
  end

  private
    def club_team_params
      params
        .require(:club_team)
        .permit(:name, :city, :state, coach_attributes: [ :first_name, :middle_name, :last_name, :phone_number, :email ], manager_attributes: [ :first_name, :middle_name, :last_name, :phone_number, :email ])
    end

    def filter_params
      players_table_filter_params
    end

    def sort_column
      %w[name city coach manager].include?(params[:sort]) ? params[:sort] : "city"
    end
end
