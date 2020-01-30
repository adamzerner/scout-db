class Tournament < ApplicationRecord
  has_many :games, inverse_of: :tournament, dependent: :destroy

  accepts_nested_attributes_for :games, allow_destroy: true

  def self.search(query)
    if query
      where("lower(name) LIKE ?", "%#{query.downcase}%")
    else
      all
    end
  end

  def sorted_games(sort_column, sort_direction)
    if sort_column === "team_one"
      result = games.sort do |a, b|
        a.team_one.name <=> b.team_one.name
      end
      result.reverse! if sort_direction === "desc"
    elsif sort_column === "team_two"
      result = games.sort do |a, b|
        a.team_two.name <=> b.team_two.name
      end
      result.reverse! if sort_direction === "desc"
    elsif sort_column === "field"
      result = games.left_joins(:field).order("fields.name #{sort_direction}")
    else
      result = games.order("#{sort_column} #{sort_direction}")
    end

    return result
  end

  def filter_options
    result = {}

    result[:teams] = get_teams_for_filter_options(self.games)
    result[:players] = get_players_for_filter_options(result[:teams])
    result[:dates] = get_dates_for_filter_options(self.games)
    result[:fields] = get_fields_for_filter_options(self.games)

    return result
  end

  def get_players_for_filter_options(teams)
    players = []

    teams.each do |team|
      team.players.each do |player|
        players << player if !players.include?(player)
      end
    end

    return players
  end

  def get_teams_for_filter_options(games)
    teams = []

    games.each do |game|
      teams << game.team_one if !teams.include?(game.team_one)
      teams << game.team_two if !teams.include?(game.team_two)
    end

    return teams
  end

  def get_dates_for_filter_options(games)
    dates = []

    games.each do |game|
      dates << game.date if !dates.include?(game.date)
    end

    return dates
  end

  def get_fields_for_filter_options(games)
    fields = []

    games.each do |game|
      fields << game.field if !fields.include?(game.date)
    end

    return fields
  end
end
