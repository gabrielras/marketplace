class AddFieldToShippings < ActiveRecord::Migration[6.0]
  def change
    remove_column :shippings, :standart_price
    add_column :shippings, :daily_delivery, :boolean
    add_column :shippings, :weekly_delivery, :boolean
    add_column :shippings, :reserve_delivery, :boolean
  end
end
