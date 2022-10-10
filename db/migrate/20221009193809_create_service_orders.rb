class CreateServiceOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :service_orders do |t|
      t.string :code
      t.string :pickup_addres
      t.string :product_code
      t.integer :weight
      t.integer :width
      t.integer :height
      t.integer :depth
      t.string :recipient_name
      t.string :recipient_address
      t.string :recipient_phone
      t.integer :distance
      t.integer :delivery_time
      t.integer :status, default: 0
      t.integer :total_cost

      t.timestamps
    end
  end
end
