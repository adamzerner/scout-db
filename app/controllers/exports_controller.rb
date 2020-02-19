require 'csv'

class ExportsController < ApplicationController
  def new
    @players = Player.all.order("first_name asc")
    @columns = [
      "Name",
      "Email",
      "Phone number",
      "Notes",
      "My notes",
      "Height",
      "Weight",
      "Position",
      "Age",
      "High school team",
      "Club team",
      "GPA",
      "PSAT score",
      "SAT score",
      "ACT score",
      "Class year",
      "Intended major"
    ]
  end

  def create
    if export_params[:format] === "CSV"
      send_data generate_arr.to_csv, filename: "scout-db-players.csv"
    elsif export_params[:format] === "Excel"
      send_data generate_arr.to_csv(col_sep: "\t"), filename: "scout-db-players.xls"
    end
  end

  private
    def export_params
      p = params
        .require(:export)
        .permit(:format, player_ids: [], columns: [])
      p[:player_ids].shift # to remove blank value
      p[:columns].shift # to remove blank value

      return p
    end

    def generate_arr
      arr = [ export_params[:columns] ]
      export_params[:player_ids].each do |player_id|
        arr << get_row_for_player(player_id)
      end

      return arr
    end

    def get_row_for_player(player_id)
      row_for_player = []
      player = Player.find(player_id)
      export_params[:columns].each do |column|
        row_for_player << get_player_val_from_col_name(player, column)
      end

      return row_for_player
    end

    def get_player_val_from_col_name(player, column)
      if column === "Name"
        return player.full_name
      elsif column === "Email"
        return player.email
      elsif column === "Phone number"
        return player.phone_number
      elsif column === "Notes"
        return player.try(:notes).try(:to_plain_text)
      elsif column === "My notes"
        return player.current_user_notes(current_user).try(:notes).try(:to_plain_text)
      elsif column === "Height"
        return player.height
      elsif column === "Weight"
        return player.weight
      elsif column === "Position"
        return player.positions
      elsif column === "Age"
        return player.age
      elsif column === "High school team"
        return player.try(:high_school_team).try(:full_name)
      elsif column === "Club team"
        return player.try(:club_team).try(:name)
      elsif column === "GPA"
        return player.gpa
      elsif column === "PSAT score"
        return player.psat_score
      elsif column === "SAT score"
        return player.sat_score
      elsif column === "ACT score"
        return player.act_score
      elsif column === "Class year"
        return player.class_year
      elsif column === "Intended major"
        return player.intended_major
      end
    end
end
