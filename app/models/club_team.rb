class ClubTeam < Team
  def self.sorted_club_teams(sort_column, sort_direction)
    if sort_column === "coach"
      return self.all.left_joins(:coach).order("coaches.first_name #{sort_direction}")
    elsif sort_column === "manager"
      return self.all.left_joins(:manager).order("managers.first_name #{sort_direction}")
    else
      club_teams_with_attr = self.where("#{sort_column} IS NOT NULL")
      club_teams_without_attr = self.where("#{sort_column} IS NULL")

      return club_teams_with_attr.order("#{sort_column} #{sort_direction}") + club_teams_without_attr
    end
  end

  def players
    club_team_players
  end
end
