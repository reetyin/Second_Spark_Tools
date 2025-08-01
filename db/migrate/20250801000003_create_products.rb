class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.text :description
      t.integer :condition, default: 0
      t.decimal :price, precision: 10, scale: 2, null: false
      t.integer :quantity, default: 0
      t.references :category, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :image_url
      t.boolean :active, default: true

      t.timestamps
    end
    
    add_index :products, :name
    add_index :products, :condition
  end
end
