require 'csv'
require './data/get_team_lines.rb'
require './data/parse_team.rb'
require './data/get_player_lines.rb'
require './data/parse_player.rb'

Player.all.delete_all
Game.all.delete_all
Coach.all.delete_all
Manager.all.delete_all
ClubTeam.all.delete_all
HighSchoolTeam.all.delete_all
Field.all.delete_all
Address.all.delete_all
Tournament.all.delete_all

lines = CSV.read('./data/cdl_showcase_2020/cdl_showcase_2020.csv').map { |line| line.first }
team_lines = get_team_lines(lines)
team_lines.each do |lines_for_team|
  team_hash = parse_team(lines_for_team)
  team_hash[:address_attributes] = { id: nil, line_one: nil, line_two: nil, city: nil, state: nil, zip: nil }
  t = HighSchoolTeam.create(team_hash)
  player_lines = get_player_lines(lines_for_team)
  player_lines.each do |lines_for_player|
    player_hash = parse_player(lines_for_player)
    player_hash[:high_school_team_id] = t.id
    player_hash[:address_attributes] = { id: nil, line_one: nil, line_two: nil, city: nil, state: nil, zip: nil }
    Player.create(player_hash)
  end
end
