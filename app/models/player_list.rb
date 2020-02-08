class PlayerList < ApplicationRecord
  belongs_to :user
  has_many :player_list_players
  has_many :players, through: :player_list_players

  def self.get_player_ids(player_list_ids)
    player_ids = []

    player_list_ids.each do |player_list_id|
      player_ids += PlayerList.find(player_list_id).player_ids.map { |player_id| player_id.to_s }
    end

    return player_ids
  end
end
