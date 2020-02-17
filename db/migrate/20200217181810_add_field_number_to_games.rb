class AddFieldNumberToGames < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :field_number, :string
  end
end
