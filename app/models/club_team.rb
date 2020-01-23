class ClubTeam < ApplicationRecord
  has_many :players
  has_many :games, as: :teamable, dependent: :destroy

  def self.search(query)
    if query
      where("lower(name) LIKE ?", "%#{query.downcase}%")
    else
      all
    end
  end
end
