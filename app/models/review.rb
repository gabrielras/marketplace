class Review < ApplicationRecord
  belongs_to :client
  belongs_to :product

  validates :text, presence: true
  validates :value,  inclusion: 1..5, presence: true

  before_create :unique_client_for_product

  def unique_client_for_product
    if Review.find_by(client_id: client, product: product).present?
      errors.add(:base, 'Não é possível ter mais de uma avaliação por cliente')
      raise ActiveRecord::Rollback
    end
  end
end
