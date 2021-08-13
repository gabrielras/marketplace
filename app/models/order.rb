class Order < ApplicationRecord
  belongs_to :cart, optional: true
  belongs_to :store
  has_many :reviews
  
  validates :type_of_payment, presence: true
  validates :client_name, presence: true
  validates :type_of_shipping, presence: true

  enum type_of_payment: {
    credit_or_debit_card_payment_machine: 0,
    cash_payment: 1,
    transfer_payment: 2,
    billet_payment: 3
  }
  enum type_of_shipping: {
    daily_delivery: 0,
    weekly_delivery: 1,
    reserve_delivery: 2,
    pick_up_at_the_store: 3
  }
end
