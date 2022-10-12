class AddDelayReasonToServiceOrder < ActiveRecord::Migration[7.0]
  def change
    add_column :service_orders, :delay_reason, :string
  end
end
