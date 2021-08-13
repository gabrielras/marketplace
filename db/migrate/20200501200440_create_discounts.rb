class CreateDiscounts < ActiveRecord::Migration[6.0]
  def change
    create_table :discounts do |t|
      t.string :title
      t.timestamp :end_time
      t.timestamp :start_time
      t.integer :status
      t.float :value, default: 1
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
