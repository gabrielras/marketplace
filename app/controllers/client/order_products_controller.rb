class Client::OrderProductsController < ApplicationController
  before_action :set_order_product, only: [:update, :destroy, :remove_one_order_product, :add_one_order_product]

  def create
    if params[:product_select][:type_product].present?
      color = params[:product_select][:type_product].split(' - ')[0]
      size = params[:product_select][:type_product].split(' - ')[1]
    else
      color = nil
      size = nil
    end
    product = Product.friendly.find(params[:product_select][:product_id])
    if @cart.blank?
      @cart = Cart.create
      @address_client = AddressClient.create(cart_id: @cart.id)
      session[:cart_id] = @cart.id
      session[:address_client_id] = @address_client.id
    end
    @order_product = @cart.add_product(product, color, size)
    if @order_product.save
      redirect_to client_cart_path(@cart), notice: 'Item adicionado ao carrinho..'
    else
      redirect_to client_cart_path(@cart), alert: 'O carrinho suporta apenas uma loja por vez, compre na mesma loja :)'
    end
  end

  def destroy
    @order_product.destroy
    redirect_to client_cart_path(@cart), notice: 'Item removido com sucesso.' 
  end

  def add_one_order_product
    @order_product.add_quantity
    redirect_to client_cart_path(@cart) 
  end

  def remove_one_order_product
    @order_product.remove_quantity
    redirect_to client_cart_path(@cart)
  end

  private
  # Use callbacks to share common setup or constraints between actions.

  def set_order_product
    @order_product = OrderProduct.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def order_product_params
    params.require(:order_product).permit(:product_id) 
  end
end
