class CreateCarts < ActiveRecord::Migration[6.0]
  def change
    create_table :carts do |t|
      t.decimal :price_shipping, :precision => 8, :scale => 2

      t.timestamps
    end
  end
end
