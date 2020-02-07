class PlayerListPlayer < ApplicationRecord
  belongs_to :player_list
  belongs_to :player
end
