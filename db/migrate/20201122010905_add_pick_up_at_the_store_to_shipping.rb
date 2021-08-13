class AddPickUpAtTheStoreToShipping < ActiveRecord::Migration[6.0]
  def change
    add_column :shippings, :pick_up_at_the_store, :boolean
  end
end
