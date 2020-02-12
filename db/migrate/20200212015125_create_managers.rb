class CreateManagers < ActiveRecord::Migration[6.0]
  def change
    create_table :managers do |t|
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.string :phone_number
      t.string :email
      t.references :team, null: false, foreign_key: true

      t.timestamps
    end
  end
end
