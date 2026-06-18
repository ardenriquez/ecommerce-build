class CreateCarts < ActiveRecord::Migration[7.2]
  def change
    create_table :carts do |t|
      t.references :user, null: false, foreign_key: true
      t.string :status, null: false, default: 'active'
      t.datetime :expires_at, null: false

      t.timestamps
    end

    add_index :carts, [:user_id, :status], unique: true, where: "status = 'active'"
  end
end
