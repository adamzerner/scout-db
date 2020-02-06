class CreateTeams < ActiveRecord::Migration[6.0]
  def change
    create_table :teams do |t|
      t.string :type
      t.string :name
      t.string :team_name
      t.string :city
      t.string :state

      t.timestamps
    end
  end
end
