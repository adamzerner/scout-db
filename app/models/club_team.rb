class ClubTeam < Team
  def self.sorted_club_teams(sort_column, sort_direction)
    if sort_column === "location"
      return self.all.order("city #{sort_direction}")
    elsif sort_column === "coach"
      return self.all.left_joins(:coach).order("coaches.first_name #{sort_direction}")
    elsif sort_column === "manager"
      return self.all.left_joins(:manager).order("managers.first_name #{sort_direction}")
    else
      return self.all.order("#{sort_column} #{sort_direction}")
    end
  end

  def players
    club_team_players
  end
end
