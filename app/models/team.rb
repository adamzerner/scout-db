class Team < ApplicationRecord
  has_many :high_school_team_players,
           foreign_key: :high_school_team_id,
           class_name: 'Player'
  has_many :club_team_players,
           foreign_key: :club_team_id,
           class_name: 'Player'
  has_many :games_as_team_one,
           dependent: :destroy,
           foreign_key: :team_one_id,
           class_name: 'Game'
  has_many :games_as_team_two,
           dependent: :destroy,
           foreign_key: :team_two_id,
           class_name: 'Game'

  def full_name
    name
  end

  def has_at_least_one_of_the_players(player_filters)
    players.each do |player|
      if player_filters.include? player.id.to_s
        return true
      end
    end

    return false
  end

  def self.search(query)
    if query
      where("lower(name) LIKE ?", "%#{query.downcase}%")
    else
      all
    end
  end
end
