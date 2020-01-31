Player.all.delete_all
Game.all.delete_all
ClubTeam.all.delete_all
HighSchoolTeam.all.delete_all
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
  middle_name: 'Brandon',
  last_name: 'Cohen',
  height: 70,
  weight: 140,
  birthday: Date.new(1992,2,3),
  high_school_team_id: HighSchoolTeam.first.id,
  club_team_id: ClubTeam.first.id,
  gpa: 3.1,
  class_year: 'Junior',
  intended_major: 'Psychology',
  email: 'mattcohen@gmail.com',
  phone_number: '921-774-8990',
  address: Address.new({
    line_one: '123 Main St.',
    line_two: '',
    city: 'Syosset',
    state: 'NY',
    zip: '11791'
  }),
  notes: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
}, {
  first_name: 'Adam',
  last_name: 'Cohen',
  height: 70,
  weight: 140,
  high_school_team_id: HighSchoolTeam.first.id,
  club_team_id: ClubTeam.first.id,
  address: Address.new,
}, {
  first_name: 'James',
  last_name: 'Ciano',
  height: 70,
  weight: 140,
  high_school_team_id: HighSchoolTeam.first.id,
  club_team_id: ClubTeam.first.id,
  address: Address.new,
}, {
  first_name: 'Justin',
  last_name: 'Leff',
  height: 70,
  weight: 140,
  high_school_team_id: HighSchoolTeam.second.id,
  club_team_id: ClubTeam.second.id,
  address: Address.new,
}, {
  first_name: 'Conner',
  last_name: 'Greene',
  height: 70,
  weight: 140,
  high_school_team_id: HighSchoolTeam.second.id,
  club_team_id: ClubTeam.second.id,
  address: Address.new,
}, {
  first_name: 'Steve',
  last_name: 'Jaycox',
  height: 70,
  weight: 140,
  high_school_team_id: HighSchoolTeam.second.id,
  club_team_id: ClubTeam.second.id,
  address: Address.new,
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
  team_two_id: HighSchoolTeam.second.id,
  field_id: Field.first.id,
  date: Date.today,
  start_time: Time.new
}, {
  tournament_id: Tournament.first.id,
  team_one_id: ClubTeam.first.id,
  team_two_id: ClubTeam.second.id,
  field_id: Field.second.id,
  date: Date.today,
  start_time: Time.new
}]
GAMES.each { |game| Game.create(game) }
