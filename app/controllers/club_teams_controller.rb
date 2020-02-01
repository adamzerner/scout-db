class ClubTeamsController < ApplicationController
  before_action :authorize_user, except: [:index, :show]
  
  def index
    @club_teams = ClubTeam.all
  end

  def show
    @club_team = ClubTeam.find(params[:id])
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
        .permit(:name)
    end
end
