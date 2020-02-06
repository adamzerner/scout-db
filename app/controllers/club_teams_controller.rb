class ClubTeamsController < ApplicationController
  before_action :authorize_user, except: [:index, :show]
  helper_method :sort_column

  def index
    @club_teams = ClubTeam.sorted_club_teams(sort_column, sort_direction)
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
        .permit(:name, :city, :state)
    end

    def sort_column
      %w[name location].include?(params[:sort]) ? params[:sort] : "location"
    end
end
