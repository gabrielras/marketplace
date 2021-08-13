class Category < ApplicationRecord
  has_many :subcategories, dependent: :destroy
  validates :title, presence: true, uniqueness: true

  def products_present?
    return true if self.subcategories.joins(:products).distinct.present?
    false
  end
end
