class CreateAddressClients < ActiveRecord::Migration[6.0]
  def change
    create_table :address_clients do |t|
      t.string :number_cep
      t.string :neighborhood
      t.string :street
      t.string :number_residence
      t.string :complement
      t.references :cart, null: false, foreign_key: true
      
      t.timestamps
    end
  end
end
