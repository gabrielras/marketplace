class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.references :client, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.string :text
      t.integer :value, default: 5

      t.timestamps
    end
  end
end
