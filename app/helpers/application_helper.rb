module ApplicationHelper
  def team_path(team)
    if team.class.to_s === "HighSchoolTeam"
      "/high_school_teams/#{team.id}"
    elsif team.class.to_s === "ClubTeam"
      "/club_teams/#{team.id}"
    end
  end
end
