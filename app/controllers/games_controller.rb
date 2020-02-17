class GamesController < ApplicationController
  before_action :authorize_user, except: [:show]

  def new
    @game = Game.new
  end

  def show
    @game = Game.find(params[:id])
  end

  def edit
    @game = Game.find(params[:id])
  end

  def update
    @game = Game.find(params[:id])

    if @game.update(game_params)
      redirect_to @game
    else
      render 'edit'
    end
  end

  private
    def game_params
      params
        .require(:game)
        .permit(:id, :commit, :team_one_id, :team_two_id, :field_id, :field_number, :date, :start_time)
    end
end
