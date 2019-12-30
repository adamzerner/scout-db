class ClubTeam < ApplicationRecord
  has_many :players
  has_many :games, as: :teamable, dependent: :destroy
end
