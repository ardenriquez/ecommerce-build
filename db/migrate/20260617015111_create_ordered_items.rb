class CreateOrderedItems < ActiveRecord::Migration[7.2]
  def change
    create_table :ordered_items do |t|
      t.references :order, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.string :name, null: false
      t.string :sku, null: false
      t.integer :quantity, null: false
      t.integer :unit_price_in_cents, null: false
      t.integer :total_price_in_cents, null: false

      t.timestamps
    end

    add_index :ordered_items, [:order_id, :product_id]
  end
end
