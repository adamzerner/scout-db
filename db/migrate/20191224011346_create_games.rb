class CreateGames < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.references :tournament, null: false, foreign_key: true
      t.references :team_one, null: false, foreign_key: { to_table: :teams }
      t.references :team_two, null: false, foreign_key: { to_table: :teams }
      t.references :field, null: false, foreign_key: true
      t.date :date
      t.datetime :start_time

      t.timestamps
    end
  end
end
