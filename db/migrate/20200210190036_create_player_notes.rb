class CreatePlayerNotes < ActiveRecord::Migration[6.0]
  def change
    create_table :player_notes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :player, null: false, foreign_key: true
      t.text :notes

      t.timestamps
    end
  end
end
