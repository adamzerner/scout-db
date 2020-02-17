class Tournament < ApplicationRecord
  has_one :tournament_director, dependent: :destroy
  has_many :games, inverse_of: :tournament, dependent: :destroy

  accepts_nested_attributes_for :tournament_director, allow_destroy: true
  accepts_nested_attributes_for :games, allow_destroy: true

  def self.search(query)
    if query
      where("lower(name) LIKE ?", "%#{query.downcase}%")
    else
      all
    end
  end

  def self.sorted_tournaments(sort_column, sort_direction)
    sorted_tournaments = nil

    if sort_column === "dates"
      tournaments_with_attr, tournaments_without_attr = self.all.partition { |t| !t.date_range.empty? }
      tournaments_with_attr = tournaments_with_attr.sort do |a,b|
        a.date_range <=> b.date_range
      end
      tournaments_with_attr.reverse! if sort_direction === "asc"
      sorted_tournaments = tournaments_with_attr + tournaments_without_attr
    elsif sort_column === "location"
      tournaments_with_attr, tournaments_without_attr = self.all.partition { |t| !t.location.empty? }
      tournaments_with_attr = tournaments_with_attr.sort do |a,b|
        a.location <=> b.location
      end
      tournaments_with_attr.reverse! if sort_direction === "asc"
      sorted_tournaments = tournaments_with_attr + tournaments_without_attr
    else
      tournaments_with_attr = self.where("#{sort_column} IS NOT NULL")
      tournaments_without_attr = self.where("#{sort_column} IS NULL")
      sorted_tournaments = tournaments_with_attr.order("#{sort_column} #{sort_direction}") + tournaments_without_attr
    end

    return sorted_tournaments
  end

  def self.filter_options
    return {
      locations: self.location_filter_options,
    }
  end

  def self.location_filter_options
    locations = []

    self.all.each do |tournament|
      if !locations.include? tournament.location
        locations << tournament.location
      end
    end

    return locations.sort { |a,b| a.name <=> b.name }
  end

  def passes_through_filters(filters)
    return (
      passes_through_location_filters(filters[:location_filters]) &&
      passes_through_earliest_start_date_filters(filters[:earliest_start_date]) &&
      passes_through_latest_start_date_filters(filters[:latest_start_date])
    )
  end

  def passes_through_location_filters(location_filters)
    return location_filters.include? self.location
  end

  def passes_through_earliest_start_date_filters(earliest_start_date)
    if self.earliest_date === nil || !earliest_start_date || earliest_start_date.length === 0
      return true
    end

    return self.earliest_date >= Date.parse(earliest_start_date)
  end

  def passes_through_latest_start_date_filters(latest_start_date)
    if self.earliest_date === nil || !latest_start_date || latest_start_date.length === 0
      return true
    end

    return self.earliest_date <= Date.parse(latest_start_date)
  end

  def games?
    return (games && games.length && games.length > 0)
  end

  def date_range
    if !games?
      return ""
    end

    return "#{earliest_date.to_formatted_s(:long)} - #{earliest_date.to_formatted_s(:long)}"
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
      if game.date
        if !earliest
          earliest = game.date
        elsif game.date < earliest
          earliest = game.date
        end
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
      teams_with_attr = games.where("team_one_id IS NOT NULL")
      teams_without_attr = games.where("team_one_id IS NULL")

      return teams_with_attr.joins("INNER JOIN teams ON teams.id = games.team_one_id").order("teams.name #{sort_direction}") + teams_without_attr
    elsif sort_column === "team_two"
      teams_with_attr = games.where("team_two_id IS NOT NULL")
      teams_without_attr = games.where("team_two_id IS NULL")

      return teams_with_attr.joins("INNER JOIN teams ON teams.id = games.team_two_id").order("teams.name #{sort_direction}") + teams_without_attr
    elsif sort_column === "field"
      teams_with_attr = games.where("field_id IS NOT NULL")
      teams_without_attr = games.where("field_id IS NULL")

      return teams_with_attr.left_joins(:field).order("fields.name #{sort_direction}") + teams_without_attr
    else
      games_with_attr = games.where("#{sort_column} IS NOT NULL")
      games_without_attr = games.where("#{sort_column} IS NULL")

      return games_with_attr.order("#{sort_column} #{sort_direction}") + games_without_attr
    end
  end

  def filter_options(current_user)
    result = {}

    result[:player_lists] = get_player_lists_for_filter_options(current_user.player_lists)
    result[:teams] = get_teams_for_filter_options(self.games)
    result[:players] = get_players_for_filter_options(result[:teams])
    result[:dates] = get_dates_for_filter_options(self.games)
    result[:fields] = get_fields_for_filter_options(self.games)

    return result
  end

  def get_player_lists_for_filter_options(player_lists)
    return player_lists.sort { |a,b| a.name <=> b.name }
  end

  def get_players_for_filter_options(teams)
    players = []

    teams.each do |team|
      team.players.each do |player|
        players << player if !players.include?(player)
      end
    end

    return players.sort { |a,b| a.first_name <=> b.first_name }
  end

  def get_teams_for_filter_options(games)
    teams = []

    games.each do |game|
      teams << game.team_one if !teams.include?(game.team_one)
      teams << game.team_two if !teams.include?(game.team_two)
    end

    return teams.sort { |a,b| a.name <=> b.name }
  end

  def get_dates_for_filter_options(games)
    dates = []

    games.each do |game|
      dates << game.date if (!dates.include?(game.date) && game.date)
    end

    return dates.sort { |a,b| a <=> b }
  end

  def get_fields_for_filter_options(games)
    fields = []

    games.each do |game|
      fields << game.field if !fields.include?(game.field)
    end

    return fields.sort { |a,b| a.name <=> b.name }
  end
end
