class CreateShops < ActiveRecord::Migration[7.2]
  def change
    create_table :shops do |t|
      t.string :name, null: false
      t.text :description
      t.string :status, null: false, default: "open"

      t.timestamps
    end
  end
end
