require 'date'

POSITIONS = ['Forward', 'Defender', 'Midfielder', 'Winger', 'Goalkeeper']

def parse_player(player_lines)
  player_hash = {}
  player_lines.each_with_index do |player_line, i|
    parse_player_line(player_hash, player_line, i)
  end

  return player_hash
end

def parse_player_line(player_hash, player_line, index)
  player_hash[:first_name], player_hash[:middle_name], player_hash[:last_name] = parse_name(player_line) if is_name?(index)
  player_hash[:email] = player_line if is_email?(player_line)
  player_hash[:birthday] = parse_dob(player_line) if is_dob?(player_line)
  player_hash[:class_year] = parse_grad_year(player_line) if is_grad_year?(player_line)
  player_hash[:phone_number] = parse_phone_number(player_line) if is_phone_number?(player_line)
  player_hash[:position], player_hash[:secondary_position], player_hash[:tertiary_position] = parse_positions(player_line) if are_positions?(player_line)
  player_hash[:gpa], player_hash[:psat_score], player_hash[:sat_score], player_hash[:act_score] = parse_academics(player_line) if has_academics?(player_line)

  return player_hash
end

def is_name?(index)
  index === 0
end

def parse_name(player_line)
  values = player_line.split(' ').map { |value| value.capitalize }

  if values.length === 1
    values.push nil
    values.push nil
  elsif values.length === 2
    values.insert(1, nil)
  end

  return values
end

def is_email?(player_line)
  player_line.include? '@'
end

def is_phone_number?(player_line)
  player_line.include? 'Phone: '
end

def parse_phone_number(player_line)
  player_line.split('Phone: ')[1]
end

def is_dob?(player_line)
  player_line.include? 'DOB: '
end

def parse_dob(player_line)
  player_line.split('DOB: ')[1]
end

def is_grad_year?(player_line)
  player_line.include? 'Grad Year: '
end

def parse_grad_year(player_line)
  grad_year = player_line.split('Grad Year: ')[1].to_i
  current_year = Date.today.year.to_i

  if grad_year < current_year
    return nil
  end

  diff = grad_year - current_year

  if diff === 0
    return 'Senior'
  elsif diff === 1
    return 'Junior'
  elsif diff === 2
    return 'Sophomore'
  elsif diff === 3
    return 'Freshman'
  elsif diff === 4
    return '8th grade'
  elsif diff === 5
    return '7th grade'
  elsif diff === 6
    return '6th grade'
  elsif diff === 7
    return '5th grade'
  else
    return nil
  end
end

def are_positions?(player_line)
  values = player_line.split(', ')
  values = values.filter { |value| POSITIONS.include? value }

  return !values.empty?
end

def parse_positions(player_line)
  values = player_line.split(', ')
  values = values.filter { |value| POSITIONS.include? value }

  return values
end

def has_academics?(player_line)
  (
    player_line.include?('GPA: ') ||
    player_line.include?('PSAT: ') ||
    player_line.include?('SAT: ') ||
    player_line.include?('ACT: ')
  )
end

def parse_academics(player_line)
  gpa = player_line.split('GPA: ')[1].to_f
  psat = player_line.split('PSAT: ')[1].to_f
  sat = player_line.split(/(^SAT: )/)[1].to_f
  act = player_line.split('ACT: ')[1].to_f

  academics = {}
  academics[:gpa] = gpa if gpa > 0
  academics[:psat_score] = psat if psat > 0
  academics[:sat_score] = sat if sat > 0
  academics[:act_score] = act if act > 0

  return academics
end
