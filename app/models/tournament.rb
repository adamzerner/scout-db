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

  def games?
    return (games && games.length && games.length > 0)
  end

  def date_range
    if !games?
      return ""
    end

    return "#{earliest_date.to_formatted_s(:long)} - #{latest_date.to_formatted_s(:long)}"
  end

  def location
    if (!games?)
      return ""
    end

    return games.first.field.location
  end

  def earliest_date
    earliest = nil

    self.games.each do |game|
      if !earliest
        earliest = game.date
      elsif game.date < earliest
        earliest = game.date
      end
    end

    return earliest
  end

  def latest_date
    latest = nil

    self.games.each do |game|
      if !latest
        latest = game.date
      elsif game.date > latest
        latest = game.date
      end
    end

    return latest
  end

  def sorted_games(sort_column, sort_direction)
    if sort_column === "team_one"
      return games.joins("INNER JOIN teams ON teams.id = games.team_one_id").order("teams.name #{sort_direction}")
    elsif sort_column === "team_two"
      return games.joins("INNER JOIN teams ON teams.id = games.team_two_id").order("teams.name #{sort_direction}")
    elsif sort_column === "field"
      return games.left_joins(:field).order("fields.name #{sort_direction}")
    else
      return games.order("#{sort_column} #{sort_direction}")
    end
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
      fields << game.field if !fields.include?(game.field)
    end

    return fields
  end
end
