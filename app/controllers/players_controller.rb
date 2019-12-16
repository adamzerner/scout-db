class PlayersController < ApplicationController
  def index
    @players = Player.all
  end

  def show
    @player = Player.find(params[:id])
  end

  def new
    @player = Player.new
    @player.address = Address.new
  end

  def edit
    @player = Player.find(params[:id])
  end

  def create
    @player = Player.new(player_params)

    if @player.save
      redirect_to @player
    else
      render 'new'
    end
  end

  def update
    @player = Player.find(params[:id])

    if @player.update(player_params)
      redirect_to @player
    else
      render 'edit'
    end
  end

  def destroy
    @player = Player.find(params[:id])
    @player.destroy

    redirect_to players_path
  end

  private
    def player_params
      params_for_player = params
        .require(:player)
        .permit(:first_name, :middle_name, :last_name, :height, :weight, :birthday, :high_school_team, :club_team, :email, :phone_number, :notes, address_attributes: [ :id, :line_one, :line_two, :city, :state, :zip ])
      params_for_player["high_school_team"] = nil
      params_for_player["club_team"] = nil

      return params_for_player
    end
end
