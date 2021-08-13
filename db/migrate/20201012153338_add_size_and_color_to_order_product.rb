class AddSizeAndColorToOrderProduct < ActiveRecord::Migration[6.0]
  def change
    add_column :order_products, :color, :string
    add_column :order_products, :size, :string
  end
end
