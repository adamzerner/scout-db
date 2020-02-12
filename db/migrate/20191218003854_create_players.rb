class CreatePlayers < ActiveRecord::Migration[6.0]
  def change
    create_table :players do |t|
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.decimal :height
      t.decimal :weight
      t.string :position
      t.string :secondary_position
      t.string :tertiary_position
      t.date :birthday
      t.references :high_school_team
      t.references :club_team
      t.decimal :gpa
      t.integer :sat_score
      t.integer :psat_score
      t.integer :act_score
      t.string :class_year
      t.string :intended_major
      t.string :email
      t.string :phone_number
      t.text :notes

      t.timestamps
    end
  end
end
