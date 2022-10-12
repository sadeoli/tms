class RenamePickupAddresToPickupAddress < ActiveRecord::Migration[7.0]
  def change
    rename_column :service_orders, :pickup_addres, :pickup_address
  end
end
