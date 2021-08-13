class Subcategory < ApplicationRecord
  has_many :products
  belongs_to :category
  validates :title, presence: true, uniqueness: true

  def products_present?
    return true if Subcategory.joins(:products).where(id: id).distinct.present?
    false
  end
end
