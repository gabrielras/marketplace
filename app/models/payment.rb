class Payment < ApplicationRecord
  belongs_to :store
  enum status: {
    free: 0,
    pending: 1,
    paid: 2,
  }

  before_create {
    self.status = 'free'
    self.payday = Time.now + 60.days
  }
  before_update :update_status_paid

  scope :payday_expired, -> { where("payday < ?", Time.now) }

  def update_all_payday_expired
    Payment.payday_expired.update_all(status: 'pending')
  end

  def update_status_paid
    payday = self.payday + 30.days if self.status == 'paid'
  end
end
