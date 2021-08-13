class CreateProductsDiscounts < ActiveRecord::Migration[6.0]
  def change
    create_table :products_discounts do |t|
      t.references :product, null: false, foreign_key: true
      t.references :discount, null: false, foreign_key: true
      t.timestamps
    end
  end
end
