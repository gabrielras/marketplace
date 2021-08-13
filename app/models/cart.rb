class Cart < ApplicationRecord
  has_many :order_products, dependent: :destroy
  has_one :order, dependent: :destroy
  has_one :address_client, dependent: :destroy

  def add_product(product, color, size)
    current_order_product = order_products.find_by(product_id: product.id, color: color, size: size)

    if current_order_product
      current_order_product.add_quantity
    else
      current_order_product = order_products.build(product_id: product.id, color: color, size: size)
      current_order_product.add_quantity
    end
    current_order_product
  end

  def current_total_price
    order_products.to_a.sum { |order_product| order_product.current_total_price }
  end

  def total_price_paid
    order_products.to_a.sum { |order_product| order_product.total_price_paid }
  end

  def find_store
    order_products.first.product.store if order_products.present?
  end

  def unique_store
    if order_products.present?
      not_unique = order_products.find { |order_product| order_product.product.store != order_products.first.product.store }
      if not_unique.present?
        errors.add(:base, 'Não é possível adicionar produtos de outra Loja, finalize ou limpe o carrinho.')
        raise ActiveRecord::Rollback
      end
    end
  end

end
