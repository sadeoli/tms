# frozen_string_literal: true

class AddVehicleAndDeliveryDateToServiceOrder < ActiveRecord::Migration[7.0]
  def change
    add_reference :service_orders, :vehicle, null: true, foreign_key: true
    add_column :service_orders, :delivery_date, :date
  end
end
