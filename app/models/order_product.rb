class OrderProduct < ApplicationRecord
  belongs_to :product
  belongs_to :cart
  belongs_to :discount, optional: true

  after_create :price_paid_associate
  before_create :unique_store

  def unique_store
    if cart.order_products.present?
      if product.store != cart.find_store
        errors.add(:base, 'O carrinho suporta apenas uma loja por vez, compre na mesma loja :)')
        raise ActiveRecord::Rollback
      end
    end
  end

  def discount_associate
    return nil if discount.present? && product.discount_select.present?
    return self.update(discount: nil) if discount.present? && !product.discount_select.present?
    self.update(discount: product.discount_select) if product.discount_select.present? 
  end

  def price_paid_associate
    self.update(price_paid: current_unit_price)
  end

  def current_total_price
    if product.discount_select.present?
      product.discount_select.price_with_initial_discount(product) * quantity.to_i
    else
      product.price * quantity.to_i
    end
  end

  def total_price_paid
    price_paid * quantity.to_i
  end

  def current_unit_price
    if product.discount_select.present?
      product.discount_select.price_with_initial_discount(product)
    else
      product.price
    end
  end

  def current_discount
    product.discount_select.id if product.discount_select.present?
  end

  def add_quantity
    new_quantity = quantity.to_i + 1
    self.update(quantity: new_quantity)
  end

  def remove_quantity
    new_quantity =  quantity.to_i - 1
    return nil if new_quantity.to_i < 1
    self.update(quantity: new_quantity)
  end
end
