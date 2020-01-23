json.players do
  json.array!(@players) do |player|
    json.name player.full_name
    json.url player_path(player)
  end
end

json.high_school_teams do
  json.array!(@high_school_teams) do |high_school_team|
    json.name high_school_team.full_name
    json.url high_school_team_path(high_school_team)
  end
end

json.club_teams do
  json.array!(@club_teams) do |club_team|
    json.name club_team.name
    json.url club_team_path(club_team)
  end
end

json.tournaments do
  json.array!(@tournaments) do |tournament|
    json.name tournament.name
    json.url tournament_path(tournament)
  end
end

json.fields do
  json.array!(@fields) do |field|
    json.name field.name
    json.url field_path(field)
  end
end
