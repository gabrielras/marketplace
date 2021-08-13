class CreatePayments < ActiveRecord::Migration[6.0]
  def change
    create_table :payments do |t|
      t.integer :status
      t.references :store, null: false, foreign_key: true
      t.timestamp :payday
 
      t.timestamps
    end
  end
end
