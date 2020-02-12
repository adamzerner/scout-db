class HighSchoolTeamsController < ApplicationController
  before_action :authorize_user, except: [:index, :show]
  helper_method :sort_column, :filter_params

  def index
    @high_school_teams = HighSchoolTeam.sorted_high_school_teams(sort_column, sort_direction)
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
    @high_school_team.coach = Coach.new
    @high_school_team.manager = Manager.new
    @high_school_team.address = Address.new
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
        .permit(:name, :team_name, coach_attributes: [ :first_name, :middle_name, :last_name, :phone_number, :email ], manager_attributes: [ :first_name, :middle_name, :last_name, :phone_number, :email ], address_attributes: [ :id, :line_one, :line_two, :city, :state, :zip ])
    end

    def filter_params
      players_table_filter_params
    end

    def sort_column
      %w[name location].include?(params[:sort]) ? params[:sort] : "location"
    end
end
