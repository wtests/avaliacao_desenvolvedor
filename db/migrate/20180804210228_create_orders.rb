class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string :customer_name, null: false
      t.string :description, null: false
      t.decimal :value, scale: 2, precision: 8, null: false
      t.integer :quantity, null: false
      t.string :address
      t.string :provider
      
      t.timestamps
    end
  end
end
