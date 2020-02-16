class HighSchoolTeam < Team
  has_one :address, as: :addressable, dependent: :destroy
  accepts_nested_attributes_for :address, allow_destroy: true

  def self.sorted_high_school_teams(sort_column, sort_direction)
    if sort_column === "location"
      return self.all.left_joins(:address).order("addresses.city #{sort_direction}")
    elsif sort_column === "coach"
      return self.all.left_joins(:coach).order("coaches.first_name #{sort_direction}")
    elsif sort_column === "manager"
      return self.all.left_joins(:manager).order("managers.first_name #{sort_direction}")
    else
      high_school_teams_with_attr = self.where("#{sort_column} IS NOT NULL")
      high_school_teams_without_attr = self.where("#{sort_column} IS NULL")

      return high_school_teams_with_attr.order("#{sort_column} #{sort_direction}") + high_school_teams_without_attr
    end
  end

  def school_name
    name
  end

  def full_name
    "#{school_name} #{team_name}"
  end

  def players
    high_school_team_players
  end

  def location
    super(address.city, address.state)
  end

  def self.search(query)
    if query
      where("
        lower(name) LIKE ? OR
        lower(team_name) LIKE ?
      ", "%#{query.downcase}%", "%#{query.downcase}%")
    else
      all
    end
  end
end
