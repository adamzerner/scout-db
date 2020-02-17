module ApplicationHelper
  def team_path(team)
    if team.type.to_s === "HighSchoolTeam"
      "/high_school_teams/#{team.id}"
    elsif team.type.to_s === "ClubTeam"
      "/club_teams/#{team.id}"
    end
  end

  def sortable(column, sort_column, sort_direction, title = nil)
    title ||= column.titleize
    direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"
    url_params = { sort: column, direction: direction }
    url_params[:page] = h(params[:page]) if h(params[:page])
    filter_params = filter_params || nil

    if filter_params
      url_params = url_params.merge(filter_params)
    end

    link = link_to title, url_params

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
