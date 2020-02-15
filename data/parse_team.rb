def parse_team(lines_for_team)
  lines_for_coach, lines_for_manager = get_lines_for_coach_and_for_manager(lines_for_team)
  team_hash = {}
  team_hash[:name] = lines_for_team[0]
  team_hash[:coach_attributes] = parse_coach_or_manager(lines_for_coach)
  team_hash[:manager_attributes] = parse_coach_or_manager(lines_for_manager)

  return team_hash
end

def get_lines_for_coach_and_for_manager(lines_for_team)
  lines_for_coach = []
  lines_for_manager = []
  i = 1

  while lines_for_team && lines_for_team[i] && !lines_for_team[i].include?('Manager: ')
    lines_for_coach << lines_for_team[i]
    i += 1
  end

  while lines_for_team && lines_for_team[i] && !lines_for_team[i].match?(/^(#\d+)/)
    lines_for_manager << lines_for_team[i]
    i += 1
  end

  return [ lines_for_coach, lines_for_manager ]
end

def parse_coach_or_manager(lines)
  hash = {}

  lines.each do |line|
    hash[:first_name], hash[:middle_name], hash[:last_name] = parse_name(line) if is_name?(line)
    hash[:email] = line if is_email?(line)
    hash[:phone_number] = line if is_phone_number?(line)
  end

  return hash
end

def is_name?(line)
  line.include?('Coach: ') || line.include?('Manager: ')
end

def parse_name(line)
  name = nil

  if line.include? 'Coach: '
    name = line.split('Coach: ')[1]
  elsif line.include? 'Manager: '
    name = line.split('Manager: ')[1]
  end

  name_components = name.split(' ').map { |name_component| name_component.capitalize }

  if name_components.length === 1
    name_components.push nil
    name_components.push nil
  elsif name_components.length === 2
    name_components.insert(1, nil)
  end

  return name_components
end

def is_email?(line)
  line.include? '@'
end

def is_phone_number?(line)
  !is_name?(line) && !is_email?(line)
end
