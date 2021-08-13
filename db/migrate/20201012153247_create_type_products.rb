class CreateTypeProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :type_products do |t|
      t.string :size
      t.string :color
      t.boolean :visibility
      t.references :product, null: false, foreign_key: true
      t.timestamps
    end
  end
end
