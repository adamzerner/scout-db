class CreatePlayerLists < ActiveRecord::Migration[6.0]
  def change
    create_table :player_lists do |t|
      t.string :name
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
