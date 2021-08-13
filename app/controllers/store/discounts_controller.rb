class Store::DiscountsController < StoreController
  include EnabledStore
  before_action :set_discount, only: [:destroy, :show]
  before_action :store_approved, only: [:edit, :new, :create]

  # GET /discounts
  # GET /discounts.json
  def index
    @discounts = Discount.joins(:products).where(products: {store_id: current_store.id}).distinct
                            .where(status: 'active')
                            .where('end_time <= ?', Time.current)
    if @discounts.present?
      @discounts.update_all(status: 'time_reached')
    end
    @q = Discount.search(params[:q])
    @discounts = @q.result.joins(:products).where(products: {store_id: current_store.id}).distinct
                                          .order('created_at DESC')
    @pagy, @discounts = pagy(@discounts, page: params[:page], items: 10)
  end 
  
  def show
  end

  # GET /discounts/new
  def new
    return redirect_to new_store_profile_path, alert: 'Conclua seu Perfil.' unless profile_is_complete?(current_store)
    return redirect_to new_store_shipping_path, alert: 'Crie sua politica de entregas.' unless shipping_is_complete?(current_store)
    return redirect_to new_store_product_path, alert: 'Você precisa cadastrar um produto.' unless current_store.products.present?
    @discount = Discount.new
  end
  
  # POST /discounts
  # POST /discounts.json
  def create
    params[:products][:id].delete("")
    return redirect_to new_store_discount_path, alert: 'É necessário selecionar um produto.'if params[:products][:id].blank?
    @discount = Discount.new(discount_params)
    if @discount.save
      params[:products][:id].each do |id|
        @discount.products << Product.find(id)
      end
      redirect_to store_discount_path(@discount), notice: 'O Desconto foi criado.'
    else
      render :new
    end
  end
  
  # DELETE /discounts/1
  # DELETE /discounts/1.json
  def destroy
    @discount.destroy
    redirect_to store_discounts_path, notice: 'O Deconto foi Removido.'
  end
  
  private

  def store_approved
    redirect_to edit_store_registration_path, notice: 'Aguarde a verificação dos Dados, isso pode levar até 2 dias úteis.' if current_store.status == 'disapprove'
  end

  def set_discount
    @discount = Discount.find(params[:id])
  end

  def discount_params
    params.require(:discount).permit(:title, :start_time, :end_time, :value, {products: []}).merge(status: 'active')
  end
end
 