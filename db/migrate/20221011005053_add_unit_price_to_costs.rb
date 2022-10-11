class AddUnitPriceToCosts < ActiveRecord::Migration[7.0]
  def change
    add_column :costs, :unit_price, :integer
  end
end
