require './data/strip_commas_off_end.rb'

def get_team_lines(lines)
  team_lines = []

  lines.map! { |line| strip_commas_off_end(line) }
  lines.each_with_index do |line, i|
    if line.include? 'Coach: '
      team_lines << []
      team_lines.last << lines[i-1]
      team_lines.last << lines[i]
    elsif !team_lines.empty?
      team_lines.last << line
    end
  end

  return team_lines
end
