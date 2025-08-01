class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :email,              null: false, default: ""
      t.string :password_digest,    null: false
      t.string :name,               null: false
      t.text :address,              null: false
      t.integer :role, default: 0

      t.timestamps null: false
    end
    add_index :users, :email, unique: true
  end
end
