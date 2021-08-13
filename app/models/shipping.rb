class Shipping < ApplicationRecord
  belongs_to :store
  
  #validates :opening_time_hour, presence: true
  #validates :opening_time_second, presence: true
  #validates :closing_time_hour, presence: true
  #validates :closing_time_second, presence: true
  validates :delivery_policy, presence: true

  has_many :shipping_by_neighborhoods
  accepts_nested_attributes_for :shipping_by_neighborhoods, reject_if: :all_blank, allow_destroy: true

  before_save :at_least_one_shipping_type

  def at_least_one_shipping_type
    if daily_delivery.blank? && weekly_delivery.blank? && reserve_delivery.blank? && pick_up_at_the_store.blank?
      errors.add(:base, 'Selecione pelo menos um tipo de envio.')
      raise ActiveRecord::Rollback
    end
  end
end
