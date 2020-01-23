class HighSchoolTeam < ApplicationRecord
  has_many :players
  has_many :games, as: :teamable, dependent: :destroy

  def name
    self.school_name
  end

  def full_name
    "#{self.school_name} #{self.team_name}"
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
