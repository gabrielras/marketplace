class AddStoreCategoryToProducts < ActiveRecord::Migration[6.0]
  def change
    add_reference :products, :store_category, optional: true, foreign_key: true
  end
end
