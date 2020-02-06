class ClubTeam < Team
  def self.sorted_club_teams(sort_column, sort_direction)
    if sort_column === "location"
      return self.all.order("city #{sort_direction}")
    else
      return self.all.order("#{sort_column} #{sort_direction}")
    end
  end

  def players
    club_team_players
  end
end
