class Player < ApplicationRecord
  belongs_to :high_school_team, class_name: "Team", optional: true
  belongs_to :club_team, class_name: "Team", optional: true
  has_one :address, as: :addressable, dependent: :destroy
  has_many :player_list_players
  has_many :player_lists, through: :player_list_players
  has_many :player_notes, dependent: :destroy

  accepts_nested_attributes_for :address, allow_destroy: true
  has_rich_text :notes

  def self.search(query)
    if query
      where("
        lower(first_name) LIKE ? OR
        lower(last_name) LIKE ?
      ", "%#{query.downcase}%", "%#{query.downcase}%")
    else
      all
    end
  end

  def self.sorted_players(sort_column, sort_direction, players = self.all)
    sorted_players = nil

    if sort_column === "class_year"
      class_years = ["5th grade", "6th grade", "7th grade", "8th grade", "Freshman", "Sophomore", "Junior", "Senior"]
      players_with_attr = players.where("#{sort_column} IS NOT NULL")
      players_without_attr = players.where("#{sort_column} IS NULL")
      players_with_attr = players_with_attr.select(&:class_year).sort do |a,b|
        class_years.index(a.class_year) <=> class_years.index(b.class_year)
      end
      players_with_attr.reverse! if sort_direction === "desc"
      sorted_players = players_with_attr + players_without_attr
    elsif sort_column === "high_school_team"
      players_with_attr = players.where("high_school_team_id IS NOT NULL")
      players_without_attr = players.where("high_school_team_id IS NULL")
      sorted_players = players_with_attr.joins("INNER JOIN teams ON teams.id = players.high_school_team_id").order("teams.name #{sort_direction}") + players_without_attr
    elsif sort_column === "club_team"
      players_with_attr = players.where("club_team_id IS NOT NULL")
      players_without_attr = players.where("club_team_id IS NULL")
      sorted_players = players_with_attr.joins("INNER JOIN teams ON teams.id = players.club_team_id").order("teams.name #{sort_direction}") + players_without_attr
    else
      players_with_attr = players.where("#{sort_column} IS NOT NULL")
      players_without_attr = players.where("#{sort_column} IS NULL")
      sorted_players = players_with_attr.order("#{sort_column} #{sort_direction}") + players_without_attr
    end

    return sorted_players
  end

  def self.filter_options(players = self.all)
    return {
      high_school_teams: self.high_school_teams_filter_options(players),
      club_teams: self.club_teams_filter_options(players),
      class_years: self.class_years_filter_options(players)
    }
  end

  def self.high_school_teams_filter_options(players)
    high_school_teams = []

    players.each do |player|
      if !high_school_teams.include? player.high_school_team
        high_school_teams << player.high_school_team
      end
    end
    high_school_teams = high_school_teams.filter { |t| !!t }

    return high_school_teams.sort { |a,b| a.name <=> b.name }
  end

  def self.club_teams_filter_options(players)
    club_teams = []

    players.each do |player|
      if !club_teams.include? player.club_team
        club_teams << player.club_team
      end
    end
    club_teams = club_teams.filter { |t| !!t }

    return club_teams.sort { |a,b| a.name <=> b.name }
  end

  def self.class_years_filter_options(players)
    order = ["Senior", "Junior", "Sophomore", "Freshman", "8th grade", "7th grade", "6th grade", "5th grade"]
    class_years = []

    players.each do |player|
      if !class_years.include?(player.class_year) && player.class_year && !player.class_year.empty?
        class_years << player.class_year
      end
    end

    return class_years.sort { |a,b| order.index(a) <=> order.index(b) }
  end

  def passes_through_filters(filters)
    return (
      passes_through_height_filters(filters[:shortest_feet], filters[:shortest_inches], filters[:tallest_feet], filters[:tallest_inches]) &&
      passes_through_weight_filters(filters[:lightest], filters[:heaviest]) &&
      passes_through_high_school_team_filters(filters[:high_school_team_filters]) &&
      passes_through_club_team_filters(filters[:club_team_filters]) &&
      passes_through_class_year_filters(filters[:class_year_filters]) &&
      passes_through_gpa_filters(filters[:smallest_gpa], filters[:largest_gpa])
    )
  end

  def passes_through_height_filters(shortest_feet, shortest_inches, tallest_feet, tallest_inches)
    if !self.height
      return true
    end

    if (!shortest_feet.empty? && !shortest_inches.empty?) && (!tallest_feet.empty? && !tallest_inches.empty?)
      shortest_height_allowed_in_inches = (shortest_feet.to_f * 12) + shortest_inches.to_f
      tallest_height_allowed_in_inches = (tallest_feet.to_f * 12) + tallest_inches.to_f

      return self.height >= shortest_height_allowed_in_inches && self.height <= tallest_height_allowed_in_inches
    elsif (!shortest_feet.empty? && !shortest_inches.empty?)
      shortest_height_allowed_in_inches = (shortest_feet.to_f * 12) + shortest_inches.to_f

      return self.height >= shortest_height_allowed_in_inches
    elsif (!tallest_feet.empty? && !tallest_inches.empty?)
      tallest_height_allowed_in_inches = (tallest_feet.to_f * 12) + tallest_inches.to_f

      return self.height <= tallest_height_allowed_in_inches
    else # both empty
      return true
    end
  end

  def passes_through_weight_filters(lightest, heaviest)
    if !self.weight
      return true
    end

    if lightest.empty? && heaviest.empty?
      return true
    elsif lightest.empty?
      return self.weight <= heaviest.to_f
    elsif heaviest.empty?
      return self.weight >= lightest.to_f
    else
      return self.weight >= lightest.to_f && self.weight <= heaviest.to_f
    end
  end

  def passes_through_high_school_team_filters(high_school_team_ids_allowed)
    if !high_school_team_ids_allowed
      return true
    end

    return high_school_team_ids_allowed.include? self.high_school_team.id.to_s
  end

  def passes_through_club_team_filters(club_team_ids_allowed)
    if !club_team_ids_allowed
      return true
    end

    return club_team_ids_allowed.include? self.club_team.id.to_s
  end

  def passes_through_class_year_filters(class_years_allowed)
    if !class_years_allowed || class_years_allowed.empty?
      return true
    end

    if !self.class_year || self.class_year.empty?
      return true
    end

    return class_years_allowed.include? self.class_year
  end

  def passes_through_gpa_filters(smallest_gpa, largest_gpa)
    if !self.gpa
      return true
    end

    if smallest_gpa.empty? && largest_gpa.empty?
      return true
    elsif smallest_gpa.empty?
      return self.gpa <= largest_gpa.to_f
    elsif largest_gpa.empty?
      return self.gpa >= smallest_gpa.to_f
    else
      return self.gpa >= smallest_gpa.to_f && self.gpa <= largest_gpa.to_f
    end
  end

  def full_name
    if first_name && !first_name.empty? && last_name && !last_name.empty?
      return "#{first_name} #{last_name}"
    elsif first_name && !first_name.empty?
      return first_name
    elsif last_name && !last_name.empty?
      return last_name
    end
  end

  def full_name_with_middle
    "#{first_name} #{middle_name} #{last_name}"
  end

  def display_height
    if !height
      return nil
    end

    return "#{feet_component_of_height}\"#{inches_component_of_height}"
  end

  def feet_component_of_height
    if !height
      return nil
    else
      (height / 12).floor
    end
  end

  def inches_component_of_height
    if !height
      return nil
    else
      return (height % 12).to_i
    end
  end

  def positions
    result = position
    result += ", #{secondary_position}" if (secondary_position && !secondary_position.empty?)
    result += ", #{tertiary_position}" if (tertiary_position && !tertiary_position.empty?)

    return result
  end

  def age
    if !birthday
      nil
    else
      ((Date.current - birthday).to_f / 365).round(2)
    end
  end

  def current_user_notes(current_user)
    q = PlayerNote.where(player_id: self.id, user_id: current_user.id)

    q.empty? ? nil : q.first
  end
end
