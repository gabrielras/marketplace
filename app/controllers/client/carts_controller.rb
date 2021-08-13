 class Client::CartsController < ApplicationController
  include CartHelper
  before_action :authorized_cart, only: [:show]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_cart

  # GET /carts/1
  # GET /carts/1.json
  def show
    cart_validation if @cart.order_products.present?
  end

  def empty_cart
    return redirect_to client_cart_path(@cart) if @cart.present?
  end

  private

  def authorized_cart
    if Cart.find(params[:id]) != @cart 
      redirect_to client_cart_path(@cart), notice: 'Não é mais possível alterar esse carrinho.'
    end
  end

  def invalid_cart
    logger.error "Tentativa de acessar carrinho inválido #{params[:id]}"
    redirect_to root_path, notice: "Esse carrinho não existe"
  end
end
