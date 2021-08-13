class Client::OrdersController < ApplicationController
  require 'uri'
  include CartHelper
  include EnumTranslateHelper
  
  def new
    cart_validation
    @order = Order.new
  end

  def create
    if order_params[:type_of_payment].blank?
      return redirect_to new_client_order_path, notice: 'Adicione uma forma de pagamento.'
    end

    if order_params[:type_of_shipping].blank?
      return redirect_to new_client_order_path, notice: 'Adicione uma forma de envio.'
    end

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

    @order = Order.new(
      client_name: order_params[:client_name],
      comment: order_params[:comment],
      type_of_payment: order_params[:type_of_payment],
      type_of_shipping: order_params[:type_of_shipping],
      cart_id: @cart.id,
      store_id: @cart.find_store.id
    )
    if @order.save
      itens = ""
      @order.cart.order_products.each do |order_product|
        itens = itens + "#{order_product.product.title}, preço da únidade: #{view_context.number_to_currency(order_product.current_unit_price)}, quantidade: #{order_product.quantity}"
        itens = itens + ", cor: #{order_product.color}" if order_product.color.present?
        itens = itens + ", tamanho: #{order_product.size}" if order_product.size.present?
        itens = itens + ";\n"
      end
      payment = translate_type_payment(@order.type_of_payment)
      shipping = translate_type_shipping(@order.type_of_shipping)
      text_message = 
      "Olá, sou o(a) #{@order.client_name}.\nGostaria de comprar os seguintes itens:\n#{itens}Preço Total do Produtos: #{view_context.number_to_currency(@order.cart.total_price_paid)}.\nForma de Entrega: #{shipping}.\nPara o Endereço: #{@order.cart.address_client.address_text}.\nForma de Pagamento será: #{payment}."
      text_message = text_message + "\nObservação: #{@order.comment}"if @order.comment.present?
      text_message = URI::encode(text_message)
      redirect_to("https://api.whatsapp.com/send?phone=55#{@order.store.profile.phone_number_whatsapp.gsub(/[^0-9]/, '')}&text=#{text_message}")
    else
      redirect_to new_client_order_path, notice: 'Pedido não finalizado!!!'
    end
  end


  private
 
  # Use callbacks to share common setup or constraints between actions.
  def order_params
    params.require(:order).permit(:client_name, :type_of_payment, :type_of_shipping, :receipt_of_payment, :comment)
  end
end
