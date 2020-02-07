class CreatePlayerListPlayers < ActiveRecord::Migration[6.0]
  def change
    create_table :player_list_players do |t|
      t.references :player_list, null: false, foreign_key: true
      t.references :player, null: false, foreign_key: true

      t.timestamps
    end
  end
end
