class PlayerList < ApplicationRecord
  belongs_to :user
  has_many :player_list_players
  has_many :players, through: :player_list_players
end
