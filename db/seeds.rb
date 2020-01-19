Player.all.delete_all
ClubTeam.all.delete_all
HighSchoolTeam.all.delete_all
Game.all.delete_all
Field.all.delete_all
Address.all.delete_all
Tournament.all.delete_all

HIGH_SCHOOL_TEAMS = [{
  school_name: 'Syosset',
  team_name: 'Braves'
}, {
  school_name: 'Jericho',
  team_name: 'Japs'
}, {
  school_name: 'Roslyn',
  team_name: 'Rich Pricks'
}, {
  school_name: 'Massapequa',
  team_name: 'Firemen'
}, {
  school_name: 'Plainview',
  team_name: 'Jews'
}]
HIGH_SCHOOL_TEAMS.each { |high_school_team| HighSchoolTeam.create(high_school_team) }

CLUB_TEAMS = [{
  name: 'Fighters'
}, {
  name: 'Flyers'
}, {
  name: 'Lightning'
}]
CLUB_TEAMS.each { |club_team| ClubTeam.create(club_team) }

FIELDS = [{
  name: 'Stillwell',
  address: Address.new
}, {
  name: 'Robbins Lane',
  address: Address.new
}, {
  name: 'Syosset High School',
  address: Address.new
}]
FIELDS.each { |field| Field.create(field) }

PLAYERS = [{
  first_name: 'Matt',
  last_name: 'Cohen',
  address: Address.new,
  height: 70,
  weight: 140,
  high_school_team_id: HighSchoolTeam.first.id,
  club_team_id: ClubTeam.first.id
}, {
  first_name: 'Adam',
  last_name: 'Cohen',
  address: Address.new,
  height: 70,
  weight: 140,
  high_school_team_id: HighSchoolTeam.first.id,
  club_team_id: ClubTeam.first.id
}, {
  first_name: 'James',
  last_name: 'Ciano',
  address: Address.new,
  height: 70,
  weight: 140,
  high_school_team_id: HighSchoolTeam.first.id,
  club_team_id: ClubTeam.first.id
}, {
  first_name: 'Justin',
  last_name: 'Leff',
  address: Address.new,
  height: 70,
  weight: 140,
  high_school_team_id: HighSchoolTeam.second.id,
  club_team_id: ClubTeam.second.id
}, {
  first_name: 'Conner',
  last_name: 'Greene',
  address: Address.new,
  height: 70,
  weight: 140,
  high_school_team_id: HighSchoolTeam.second.id,
  club_team_id: ClubTeam.second.id
}, {
  first_name: 'Steve',
  last_name: 'Jaycox',
  address: Address.new,
  height: 70,
  weight: 140,
  high_school_team_id: HighSchoolTeam.second.id,
  club_team_id: ClubTeam.second.id
}]
PLAYERS.each { |player| Player.create(player) }

TOURNAMENTS = [{
  name: 'The Ultimate'
}, {
  name: 'The Spectacular'
}, {
  name: 'The Magnificent'
}]
TOURNAMENTS.each { |tournament| Tournament.create(tournament) }

GAMES = [{
  tournament_id: Tournament.first.id,
  team_one_id: HighSchoolTeam.first.id,
  team_one_type: 'HighSchoolTeam',
  team_two_id: HighSchoolTeam.second.id,
  team_two_type: 'HighSchoolTeam',
  field_id: Field.first.id,
  date: Date.new,
  start_time: Time.new
}, {
  tournament_id: Tournament.first.id,
  team_one_id: ClubTeam.first.id,
  team_one_type: 'ClubTeam',
  team_two_id: ClubTeam.second.id,
  team_two_type: 'ClubTeam',
  field_id: Field.second.id,
  date: Date.new,
  start_time: Time.new
}]
GAMES.each { |game| Game.create(game) }
