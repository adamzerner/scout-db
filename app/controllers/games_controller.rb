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

    puts "test"
    puts game_params.inspect

    if @game.update(game_params)
      redirect_to @game
    else
      puts @game.errors.full_messages.inspect
      render 'edit'
    end
  end

  private
    def game_params
      augment_team_ids(params
        .require(:game)
        .permit(:team_one_id, :team_two_id, :field_id, :date, :start_time))

    end

    def augment_team_ids(curr_game)
      if curr_game[:team_one_id].include?("high-school-team")
        curr_game[:team_one_id] = curr_game[:team_one_id].split(':').last
        curr_game[:team_one_type] = "HighSchoolTeam"
      elsif curr_game[:team_one_id].include?("club-team")
        curr_game[:team_one_id] = curr_game[:team_one_id].split(':').last
        curr_game[:team_one_type] = "ClubTeam"
      end

      if curr_game[:team_two_id].include?("high-school-team")
        curr_game[:team_two_id] = curr_game[:team_two_id].split(':').last
        curr_game[:team_two_type] = "HighSchoolTeam"
      elsif curr_game[:team_two_id].include?("club-team")
        curr_game[:team_two_id] = curr_game[:team_two_id].split(':').last
        curr_game[:team_two_type] = "ClubTeam"
      end

      return curr_game
    end
end
