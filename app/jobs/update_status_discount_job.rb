class UpdateStatusDiscountJob < ApplicationJob
  queue_as :defaul

  def perform
    @discounts = discount.joins(:product)
                         .where(status: 'active')
                         .where('end_time <= ?', Time.current)
    @discounts.update_all(status: 'time_reached') if @discounts.present?
  end
end
