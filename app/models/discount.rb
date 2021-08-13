class Discount < ApplicationRecord
  before_create {
    self.status = Discount.statuses[:active]
  }
  before_destroy :destroy_valid
  before_create  :discount_valid

  has_many :products_discounts, dependent: :destroy
  has_many :products, :through => :products_discounts
  has_many :order_products, dependent: :destroy
  
  enum status: { 
    time_reached: 0,
    active: 1
  }

  validates_associated :products
  validates :end_time, presence: true
  validates :start_time, presence: true
  validates :title, presence: true
  validates :value, presence: true

  def price_with_initial_discount(product)
    product.price - (product.price * (value/100))
  end

  def status_update 
    self.update(status: 'time_reached') if end_time <= Time.current
  end

  def discount_valid
    if start_time > end_time
      errors.add(:base, 'A data final deve ser maior que data inicial em uma hora.')
      raise ActiveRecord::Rollback
    end

    if (end_time - start_time).days <= 14
      errors.add(:base, 'A oferta não pode durar mais que duas semana.')
      raise ActiveRecord::Rollback
    end

    if start_time <= Time.current || end_time <= Time.current
      errors.add(:base, 'A data de início e encerramento devem ser maiores que o momento atual.')
    end
  end

  def destroy_valid
    if OrderProduct.where({discount_id: id}).first != nil
      errors.add(:base, 'Não é possível excluir desconto, pois já ocorreu venda(as) usando ele.')
      raise ActiveRecord::Rollback
    end
  end
end
