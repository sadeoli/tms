class CreateTimescales < ActiveRecord::Migration[7.0]
  def change
    create_table :timescales do |t|
      t.integer :min_distance
      t.integer :max_distance
      t.integer :deadline
      t.references :transportation_modal, null: false, foreign_key: true

      t.timestamps
    end
  end
end
