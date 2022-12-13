# frozen_string_literal: true

class CreateTransportationModals < ActiveRecord::Migration[7.0]
  def change
    create_table :transportation_modals do |t|
      t.string :name
      t.integer :max_distance
      t.integer :min_distance
      t.integer :max_weight
      t.integer :min_weight
      t.integer :flat_rate
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
