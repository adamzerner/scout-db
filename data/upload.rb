require './data/get_team_lines'
require './data/get_player_lines'
require './data/parse_player'

lines = [
  'Page 3,,,,,',
  'Girls U15 - U15 Girls Red Division,,,,,',
  'CHARGERS SC CLW G2005 SELECT - Girls U15 - Florida,,,,,',
  'Coach: Marco Pollastri,,,,,',
  'pollmk@msn.com,,,,,',
  'Manager: Kelly Reukauf,,,,,',
  '727-216-5380,,,,,',
  'kelly.reukauf@yahoo.com,,,,,',
  '#1,,,,,',
  'MADISON GATES,,,,,',
  'jandkgates@hotmail.com,,,,,',
  'DOB: 2/20/2005,,,,,',
  'Phone: 727-849-8652,,,,,',
  '#2,,,,,',
  'Katherine Phy,,,,,',
  'lisakphy@gmail.com,,,,,',
  'DOB: 9/26/2005,,,,,',
  'Grad Year: 4,,,,,',
  'Phone: 9545291031,,,,,',
  '#3,,,,,',
  'Ava Marchido,,,,,',
  '1101christina@gmail.com,,,,,',
  'DOB: 12/6/2005,,,,,',
  'Grad Year: 2024,,,,,',
  'Phone: 727-364-7469,,,,,',
  '#4,,,,,',
  'Cecelia Hopwood,,,,,',
  'drsehopwood@aol.com,,,,,',
  'DOB: 1/25/2006,,,,,',
  'Phone: 7276980769,,,,,',
  '#6,,,,,',
  'Abby Toscani,,,,,',
  'joykris.toscani@gmail.com,,,,,',
  'DOB: 1/24/2006,,,,,',
  'Grad Year: 2024,,,,,',
  'Phone: (727) 741-0621,,,,,',
  '#7,,,,,',
  'Madison Quian,,,,,',
  'Marciequian@yahoo.com,,,,,',
  'DOB: 12/29/2005,,,,,',
  'Phone: (727) 385-9815,,,,,',
  '#8,,,,,',
  'KELLI SLATER,,,,,',
  'gabrielcslater@gmail.com,,,,,',
  'DOB: 7/8/2005,,,,,',
  'Grad Year: 2023,,,,,',
  'Phone: 7274477048,,,,,',
  '#9,,,,,',
  'ABIGAIL HABER,,,,,',
  'mhaber@tampabay.rr.com,,,,,',
  'DOB: 9/9/2005,,,,,',
  'Grad Year: 2024,,,,,',
  'Phone: 727-734-7901,,,,,',
  '#10,,,,,',
  'ILIANA POLLASTRI,,,,,',
  'pollmk@msn.com,,,,,',
  'DOB: 11/17/2005,,,,,',
  'Phone: 727.688.3134,,,,,',
  '#11,,,,,',
  'Ava Menke,,,,,',
  'denisem1201@me.com,,,,,',
  'DOB: 2/22/2006,,,,,',
  'Phone: 7275106585,,,,,',
  '#12,,,,,',
  'Olivia Davidson,,,,,',
  'Davidsonkimber@me.com,,,,,',
  'DOB: 2/10/2006,,,,,',
  'Phone: 7276315421,,,,,',
  '#14,,,,,',
  'Emma Reukauf,,,,,',
  'kelly.reukauf@yahoo.com,,,,,',
  'DOB: 8/16/2005,,,,,',
  'Phone: 727-216-5380,,,,,',
  '#15,,,,,',
  'Yuliana Gomez,,,,,',
  'Marinaperez38@live.com,,,,,',
  'DOB: 5/15/2005,,,,,',
  'Phone: 7272137154,,,,,',
  '#16,,,,,',
  'Morgan Hoag,,,,,',
  'jessehoag@gmail.com,,,,,',
  'DOB: 6/16/2005,,,,,',
  'Grad Year: 2023,,,,,',
  'Phone: 7276443656,,,,,',
  '#17,,,,,',
  'JANE MYERS,,,,,',
  'brad_myers@jabil.com,,,,,',
  'DOB: 1/25/2005,,,,,',
  'Grad Year: 2023,,,,,',
  'Phone: 7274608733,,,,,',
  '#18,,,,,',
  'Giselle Kinmonth,,,,,',
  'bkinmonth@tampabay.rr.com,,,,,',
  'DOB: 1/7/2005,,,,,',
  'Phone: 727-253-4395,,,,,',
  '#24,,,,,',
  'MAUREEN MCGREGOR,,,,,',
  'glenmcgregor@msn.com,,,,,',
  'DOB: 3/31/2005,,,,,',
  'Phone: 813-401-7005,,,,,',
  '#27,,,,,',
  'Emma Elliott,,,,,',
  'brikelgrace@verizon.net,,,,,',
  'DOB: 6/27/2005,,,,,',
  'Grad Year: 2023,,,,,',
  'Phone: 7374221270,,,,,',
  'Page 4,,,,,',
  'Girls U15 - U15 Girls Red Division,,,,,',
  'CNTBU TAMPA BAY UNITED PREMIER GIRLS 2005 - Girls U15 - Florida,,,,,',
  'State Cup 2019 - Quarter-finalist Coach: Randy Villalba,,,,,',
  '7276882310,,,,,',
  'rvillalba@tbusc.com,,,,,',
  'Manager: Nikki Gill,,,,,',
  'cnlw@live.ca,,,,,',
  '#1,,,,,',
  'Kaitlyn Cofone,,,,,',
  'kaitcofone@yahoo.com,,,,,',
  'Goalkeeper,,,,,',
  'DOB: 1/14/2005,,,,,',
  'Grad Year: 2023,,,,,',
  'Phone: 813-992-1189,,,,,',
  '#1,,,,,',
  'Avery Reese,,,,,',
  'reese.vanessa1@gmail.com,,,,,',
  'DOB: 9/10/2005,,,,,',
  'Grad Year: 2023,,,,,',
  'Phone: 9106190438,,,,,',
  '#2,,,,,',
  'Avery Allen,,,,,',
  'terrybrad@verizon.net,,,,,',
  'DOB: 6/2/2005,,,,,',
  'Phone: 4043587576,,,,,',
  '#3,,,,,',
  'Alina Martin,,,,,',
  'vickimartin@mac.com,,,,,',
  'DOB: 7/15/2005,,,,,',
  'Phone: 727-808-1305,,,,,',
]

team_lines = get_team_lines(lines)
team_lines.each do |lines_for_team|
  team_hash = parse_team(lines_for_team)
  # create team with coach and manager
  player_lines = get_player_lines(lines_for_team)
  player_lines.each do |lines_for_player|
    player_hash = parse_player(lines_for_player)
    # create player
  end
end