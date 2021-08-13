class ShippingByNeighborhood < ApplicationRecord
  belongs_to :shipping, optional: true

  validates :neighborhood, presence: true
  validates :price, presence: true
  attr_accessor :number_cep_attribute
end
