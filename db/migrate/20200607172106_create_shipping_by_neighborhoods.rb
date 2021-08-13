class CreateShippingByNeighborhoods < ActiveRecord::Migration[6.0]
  def change
    create_table :shipping_by_neighborhoods do |t|
      t.string :neighborhood
      t.float :price, default: 0, :precision => 8, :scale => 2
      t.references :shipping, null: false, foreign_key: true

      t.timestamps
    end
  end
end
