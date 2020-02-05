class HighSchoolTeamsController < ApplicationController
  before_action :authorize_user, except: [:index, :show]

  def index
    @high_school_teams = HighSchoolTeam.all
  end

  def show
    @high_school_team = HighSchoolTeam.find(params[:id])
    @filter_options = Player.filter_options(@high_school_team.players)
    @filters_to_apply = players_table_filter_params && !players_table_filter_params.empty?
    @players = Player.sorted_players(players_table_sort_column, sort_direction, @high_school_team.players)
    @players = @filters_to_apply ? get_filtered_players(@players, players_table_filter_params) : @players
  end

  def new
    @high_school_team = HighSchoolTeam.new
  end

  def edit
    @high_school_team = HighSchoolTeam.find(params[:id])
  end

  def create
    @high_school_team = HighSchoolTeam.new(high_school_team_params)

    if @high_school_team.save
      redirect_to @high_school_team
    else
      render 'new'
    end
  end

  def update
    @high_school_team = HighSchoolTeam.find(params[:id])

    if @high_school_team.update(high_school_team_params)
      redirect_to @high_school_team
    else
      render 'edit'
    end
  end

  def destroy
    @high_school_team = HighSchoolTeam.find(params[:id])
    @high_school_team.destroy

    redirect_to high_school_teams_path
  end

  private
    def high_school_team_params
      params
        .require(:high_school_team)
        .permit(:school_name, :team_name)
    end
end
