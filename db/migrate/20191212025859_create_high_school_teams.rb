class CreateHighSchoolTeams < ActiveRecord::Migration[6.0]
  def change
    create_table :high_school_teams do |t|
      t.string :school_name
      t.string :team_name

      t.timestamps
    end
  end
end
