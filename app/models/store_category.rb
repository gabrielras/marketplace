class StoreCategory < ApplicationRecord
  belongs_to :store
  has_many :products

  validates :title, presence: true
end
