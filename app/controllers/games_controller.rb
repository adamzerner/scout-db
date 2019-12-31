class GamesController < ApplicationController
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
        .permit(:team_one_id, :team_two_id, :field_id, :date, :start_time)
    end
end
