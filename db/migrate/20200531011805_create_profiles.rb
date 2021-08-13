class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.string :cep_number
      t.string :state
      t.string :city
      t.string :street
      t.string :neighborhood
      t.string :number_residence
      t.string :complement
      t.string :thumbnail
      t.boolean :credit_or_debit_card_payment_machine
      t.boolean :cash_payment
      t.boolean :billet_payment
      t.boolean :transfer_payment
      t.string :phone_number_whatsapp
      t.string :link_to_facebook
      t.string :link_to_instagram
      t.references :store, null: false, foreign_key: true
      t.timestamps
    end
  end
end
