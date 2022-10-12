class AddShipDateServiceOrder < ActiveRecord::Migration[7.0]
  def change
    add_column :service_orders, :ship_date, :date
  end
end
