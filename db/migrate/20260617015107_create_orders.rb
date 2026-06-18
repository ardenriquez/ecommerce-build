class CreateOrders < ActiveRecord::Migration[7.2]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.references :shop, null: false, foreign_key: true
      t.integer :total_in_cents, null: false
      t.string :status, null: false, default: "pending_payment"
      t.string :payment_method, null: false
      t.string :payment_reference

      t.timestamps
    end

    add_index :orders, [:user_id, :shop_id]
  end
end
