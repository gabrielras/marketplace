class CreateOrderProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :order_products do |t|
      t.references :product, null: false, foreign_key: true
      t.integer :quantity, default: 0
      t.references :cart, null: false, foreign_key: true
      t.references :discount, optional: true, foreign_key: true
      t.decimal :price_paid, :precision => 8, :scale => 2

      t.timestamps
    end
  end
end
