module CartHelper
  include CartValidation

  def cart_validation
    if @cart.order_products.blank?
      return redirect_to client_cart_path(@cart), notice: 'Seu carrinho está vazio.'
    end

    if !valid_items_for_the_cart?(@cart)
      update_valid_items(@cart)
      return redirect_to client_cart_path(@cart), notice: 'Alguns produtos não estão mais disponíveis pela loja.'
    end

    if !valid_discounts_for_the_cart?(@cart)
      update_valid_discounts(@cart)
      return redirect_to client_cart_path(@cart), notice: 'Houve uma atualização no seu carrinho de compra.'
    end
  end
end
