module ApplicationHelper
  def team_path(team)
    if team.type.to_s === "HighSchoolTeam"
      "/high_school_teams/#{team.id}"
    elsif team.type.to_s === "ClubTeam"
      "/club_teams/#{team.id}"
    end
  end

  def sortable(column, title = nil)
    title ||= column.titleize
    direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"
    link = link_to title, sort: column, direction: direction

    if column == sort_column && sort_direction == "asc"
      icon = " ▴"
    elsif column == sort_column && sort_direction == "desc"
      icon = " ▾"
    else
      icon = nil
    end

    return link + icon
  end
end
