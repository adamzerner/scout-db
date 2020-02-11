class PlayerNotesController < ApplicationController
  def create
    @player_note = PlayerNote.new(player_note_params)
    @player_note.player_id = params[:player_id].to_i
    @player_note.user_id = current_user.id

    if @player_note.save
      redirect_to player_path(params[:player_id])
    else
      render 'players/show'
    end
  end

  def update
    @player_note = PlayerNote.find(params[:id])
    @player_note.notes = player_note_params[:notes]
    @player_note.player_id = params[:player_id].to_i
    @player_note.user_id = current_user.id

    if @player_note.save
      redirect_to player_path(params[:player_id])
    else
      render 'players/show'
    end
  end

  private
    def player_note_params
      params.require(:player_note).permit(:notes)
    end
end
