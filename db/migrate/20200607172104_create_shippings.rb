class CreateShippings < ActiveRecord::Migration[6.0]
  def change
    create_table :shippings do |t|
      t.float :price_for_free_shipping, :precision => 8, :scale => 2
      t.float :standart_price, :precision => 8, :scale => 2
      t.string :delivery_policy
      t.references :store, null: false, foreign_key: true
      t.integer :opening_time_hour
      t.integer :opening_time_second
      t.integer :closing_time_hour
      t.integer :closing_time_second
      t.timestamps
    end
  end
end
