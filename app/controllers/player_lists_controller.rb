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
    @player_list = PlayerList.new({ name: player_list_params[:name] })
    @player_list.user = current_user
    @player_list.player_ids = player_list_params[:player_ids]

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
      result = params
        .require(:player_list)
        .permit(:name, player_ids: [])
      result[:player_ids] = result[:player_ids].map { |player_id| player_id.to_i }

      return result
    end
end
