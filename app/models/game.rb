class Game < ApplicationRecord
  belongs_to :tournament
  belongs_to :team_one, polymorphic: true
  belongs_to :team_two, polymorphic: true
  belongs_to :field, optional: true

  def name
    "#{team_one.name} vs #{team_two.name}"
  end

  def long_name
    "#{team_one.name} vs #{team_two.name} on #{date.to_formatted_s(:long)}"
  end

  def passes_through_filters(filters)
    return (
      passes_through_player_filters(filters[:player_filters]) &&
      passes_through_team_filters(filters[:team_filters]) &&
      passes_through_date_filters(filters[:date_filters]) &&
      passes_through_field_filters(filters[:field_filters]) &&
      passes_through_start_time_filters(filters[:earliest_start_time], filters[:latest_start_time])
    )
  end

  def passes_through_player_filters(player_filters)
    if !player_filters
      return true
    else
      return has_at_least_one_of_the_players(player_filters)
    end

  end

  def has_at_least_one_of_the_players(players)
    has_at_least_one_of_the_players = false

    team_one.players.each do |player|
      if player_filters.include? player.id.to_s
        has_at_least_one_of_the_players = true
      end
    end

    team_two.players.each do |player|
      if player_filters.include? player.id.to_s
        has_at_least_one_of_the_players = true
      end
    end

    return has_at_least_one_of_the_players
  end

  def passes_through_team_filters(team_filters)
    return true if !team_filters

    result = false

    team_filters.each do |team_filter|
      team_filter_class, team_filter_id = team_filter.split('-')

      if (
        (team_one.class.to_s === team_filter_class && team_one.id.to_s === team_filter_id) ||
        (team_two.class.to_s === team_filter_class && team_two.id.to_s === team_filter_id)
      )
        result = true
      end
    end

    return result
  end

  def passes_through_date_filters(date_filters)
    return date_filters.try(:include?, date.to_s)
  end

  def passes_through_field_filters(field_filters)
    return field_filters.try(:include?, field.id.to_s)
  end

  def passes_through_start_time_filters(earliest_start_time, latest_start_time)
    if earliest_start_time.empty? || latest_start_time.empty?
      return true
    end

    return (
      start_time_later_than_or_equal_to(earliest_start_time) &&
      start_time_earlier_than_or_equal_to(latest_start_time)
    )
  end

  def start_time_aggregate_mins
    return (start_time.hour * 60) + start_time.min
  end

  def get_str_time_aggregate_mins(str_time)
    hours = str_time.split(':')[0].to_i
    minutes = str_time.split(':')[1].to_i

    return (60 * hours) + minutes
  end

  def start_time_later_than_or_equal_to(str_time)
    return start_time_aggregate_mins >= get_str_time_aggregate_mins(str_time)
  end

  def start_time_earlier_than_or_equal_to(str_time)
    return start_time_aggregate_mins <= get_str_time_aggregate_mins(str_time)
  end
end
