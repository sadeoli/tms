# frozen_string_literal: true

class AddTransportationModalToCosts < ActiveRecord::Migration[7.0]
  def change
    add_reference :costs, :transportation_modal, null: false, foreign_key: true
  end
end
