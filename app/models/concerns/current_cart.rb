module CurrentCart
  private

  def set_cart
    @cart = Cart.find(session[:cart_id])
    if @cart.order.present?
      session[:cart_id] = nil
    end
  rescue ActiveRecord::RecordNotFound
    return nil    
  end
end
