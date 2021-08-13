class RemoveProductToDiscount < ActiveRecord::Migration[6.0]
  def change
    remove_column :discounts, :product_id
  end
end
