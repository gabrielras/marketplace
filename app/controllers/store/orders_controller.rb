class Store::OrdersController < StoreController
  before_action :set_order, only: [:show]

  # GET /orders
  # GET /orders.json
  def index
    @q = Order.search(params[:q])
    @orders = @q.result.includes(:cart)
                        .where(store_id: current_store.id)
                        .where.not(status: 'pending')
                        .order('created_at DESC')
    @pagy, @orders = pagy(@orders, page: params[:page], items: 10)
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end
  
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_order
    @order = Order.find(params[:id])
    authorized_order
  end

  def authorized_order
    if current_store.id != @order.store.id
      redirect_to client_cart_path(@cart), notice: 'Você não está autorizado a editar esse Pedido.'
    end
  end
  
end
