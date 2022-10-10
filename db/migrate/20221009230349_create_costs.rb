class CreateCosts < ActiveRecord::Migration[7.0]
  def change
    create_table :costs do |t|
      t.integer :type
      t.integer :maximum
      t.integer :minimum

      t.timestamps
    end
  end
end
