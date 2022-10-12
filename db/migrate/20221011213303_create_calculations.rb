class CreateCalculations < ActiveRecord::Migration[7.0]
  def change
    create_table :calculations do |t|
      t.references :service_order, null: false, foreign_key: true
      t.references :transportation_modal, null: false, foreign_key: true

      t.timestamps
    end
  end
end
