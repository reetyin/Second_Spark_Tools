class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.string :order_number, null: false
      t.references :user, null: false, foreign_key: true
      t.decimal :total_amount, precision: 10, scale: 2, null: false
      t.integer :status, default: 0
      t.text :shipping_address
      t.text :billing_address
      t.datetime :shipped_at
      t.datetime :delivered_at

      t.timestamps
    end
    
    add_index :orders, :order_number, unique: true
  end
end
