class AddFieldToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :type_of_shipping, :integer
  end
end
