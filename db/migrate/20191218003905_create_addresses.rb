class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.string :line_one
      t.string :line_two
      t.string :city
      t.string :state
      t.string :zip
      t.references :addressable, polymorphic: true

      t.timestamps
    end
  end
end
