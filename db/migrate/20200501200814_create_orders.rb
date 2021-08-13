class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.integer :type_of_payment
      t.string :comment
      t.references :cart, null: false, foreign_key: true
      t.references :store, null: false, foreign_key: true
      t.timestamps
    end
  end
end
