class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :title
      t.float :price, default: 0, :precision => 8, :scale => 2
      t.string :description, null: false
      t.references :subcategory, null: false, foreign_key: true
      t.integer :visibility, default: true
      t.integer :status
      t.integer :quantity, default: 1
      t.json :images
      t.references :store, null: false, foreign_key: true
      t.string :thumbnail

      t.timestamps
    end
  end
end
