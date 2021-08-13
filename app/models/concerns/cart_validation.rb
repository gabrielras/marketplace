module CartValidation
  private

  def valid_items_for_the_cart?(cart)
    response = cart.order_products.find{ |order_product| order_product.product.visibility != 'true' } if cart.present?
    return false if response.present?
    true
  end

  def valid_discounts_for_the_cart?(cart)
    response = cart.order_products.find{ |order_product| order_product.product.discount_select != order_product.discount} if cart.present?
    return false if response.present?
    true
  end

  def update_valid_items(cart)
    cart.order_products.each do |order_product|
      order_product.destroy if order_product.product.visibility == 'false'
    end
  end

  def update_valid_discounts(cart)
    cart.order_products.each do |order_product|
      order_product.update(
        discount_id: order_product.current_discount,
        price_paid: order_product.current_unit_price
      ) if order_product.product.discount_select != order_product.discount
    end
  end
end
