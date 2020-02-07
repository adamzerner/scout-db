class PlayerListsController < ApplicationController
  def index
    @player_lists = current_user.player_lists
  end

  def show
    @player_list = PlayerList.find(params[:id])
  end

  def new
    @player_list = PlayerList.new
  end

  def edit
    @player_list = PlayerList.find(params[:id])
  end

  def create
    @player_list = PlayerList.new(player_list_params)

    if @player_list.save
      redirect_to @player_list
    else
      render 'new'
    end
  end

  def update
    @player_list = PlayerList.find(params[:id])

    if @player_list.update(player_list_params)
      redirect_to @player_list
    else
      render 'edit'
    end
  end

  def destroy
    @player_list = PlayerList.find(params[:id])
    @player_list.destroy

    redirect_to player_lists_path
  end

  private
    def player_list_params
      return params
        .require(:player_list)
        .permit(:name, players: [])
    end
end
