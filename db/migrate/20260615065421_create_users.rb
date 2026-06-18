class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :password_hash
      t.string :role, null: false, default: "customer"

      t.timestamps
    end

    add_index :users, :email, unique: true
  end
end
