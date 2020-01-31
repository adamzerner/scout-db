class HighSchoolTeam < Team
  def initialize(args)
    if (!args)
      super()
    elsif (args)
      super({
        name: args[:school_name],
        team_name: args[:team_name]
      })
    end
  end

  def update(args)
    if (!args)
      super()
    elsif (args)
      super({
        name: args[:school_name],
        team_name: args[:team_name]
      })
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

  def self.search(query)
    if query
      where("
        lower(school_name) LIKE ? OR
        lower(team_name) LIKE ?
      ", "%#{query.downcase}%", "%#{query.downcase}%")
    else
      all
    end
  end
end
