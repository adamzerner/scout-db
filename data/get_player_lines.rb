require './data/strip_commas_off_end.rb'

def get_player_lines(lines)
  player_lines = []

  lines.map! { |line| strip_commas_off_end(line) }
  lines.each do |line|
    if line =~ /#\d+/
      player_lines << []
    elsif !player_lines.empty?
      player_lines.last << line
    end
  end

  return player_lines
end
