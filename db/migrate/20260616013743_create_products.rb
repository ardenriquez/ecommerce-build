class CreateProducts < ActiveRecord::Migration[7.2]
  def change
    create_table :products do |t|
      t.references :shop, null: false, foreign_key: true
      t.string :name, null: false
      t.text :description
      t.string :sku, null: false
      t.integer :price_in_cents, null: false
      t.integer :max_order_quantity
      t.integer :stock_quantity, null: false, default: 0
      t.string :status, null: false, default: 'available'

      t.timestamps
    end

    # sku is unique per shop
    add_index :products, [:shop_id, :sku], unique: true
  end
end
