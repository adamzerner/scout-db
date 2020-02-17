class CreateTournamentDirectors < ActiveRecord::Migration[6.0]
  def change
    create_table :tournament_directors do |t|
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.string :email
      t.string :phone_number
      t.references :tournament, null: false, foreign_key: true

      t.timestamps
    end
  end
end
