class HighSchoolTeam < ApplicationRecord
  has_many :players
  has_many :games, as: :teamable, dependent: :destroy

  def name
    self.school_name
  end
end
