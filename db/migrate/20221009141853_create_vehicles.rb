class CreateVehicles < ActiveRecord::Migration[7.0]
  def change
    create_table :vehicles do |t|
      t.string :license_plate
      t.string :model
      t.string :brand
      t.integer :max_weight
      t.integer :manufacture_year
      t.references :transportation_modal, null: false, foreign_key: true
      t.integer :status

      t.timestamps
    end
  end
end
