class Store::ShippingsController < StoreController
  before_action :set_shipping, except: [:new, :create, :index]

  def index
    @shipping = Store.find(current_store.id).shipping
    if (@shipping != nil) 
      return redirect_to edit_store_shipping_path(@shipping) 
    end
    redirect_to new_store_shipping_path
  end

  def show
    redirect_to edit_store_shipping_path(@shipping)
  end

  # GET /shippings/new
  def new
    @shipping = Store.find(current_store.id).shipping
    if (@shipping != nil) 
      return redirect_to edit_store_shipping_path(@shipping) 
    end
    @shipping = Shipping.new
  end
  
  # GET /shippings/1/edit
  def edit
  end
  
  # POST /shippings
  # POST /shippings.json
  def create
    @shipping = Shipping.new(shipping_params)
    if @shipping.save
      redirect_to store_products_path, notice: 'Dados de envio criado com sucesso. Agora você pode criar produtos.'
    else
      render :new
    end
  end
  
  # PATCH/PUT /shippings/1
  # PATCH/PUT /shippings/1.json
  def update
    if @shipping.update_attributes(shipping_params)
      redirect_to edit_store_shipping_path(@shipping), notice: 'Dados de envio atualizado com sucesso.'
    else
      render :edit
    end
  end
  
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_shipping
    @shipping = Shipping.find(params[:id])
    authorized_shipping
  end

  def authorized_shipping
    if current_store.id != @shipping.store.id
      redirect_to new_store_shipping_path, notice: 'Você não está autorizado a editar o Detalhe da entrega.'
    end
  end
  
  # Never trust parameters from the scary internet, only allow the white list through.
  def shipping_params 
    params.require(:shipping).permit(:price_for_free_shipping, :standart_price,
      :delivery_policy, :daily_delivery, :weekly_delivery, :reserve_delivery, :pick_up_at_the_store,
      shipping_by_neighborhoods_attributes: ShippingByNeighborhood.attribute_names.map(&:to_sym).push(:_destroy)).merge(store_id: current_store.id)
  end
end
