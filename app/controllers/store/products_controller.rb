class Store::ProductsController < StoreController
  include EnabledStore
  before_action :set_product, only: [:edit, :update, :destroy]
  before_action :store_approved, only: [:edit, :new, :create, :update]

  # GET /products
  # GET /products.json
  def index
    @q = Product.search(params[:q])
    @products = @q.result.where(:store_id => current_store.id)
                          .order('created_at DESC')
    @pagy, @products = pagy(@products, page: params[:page], items: 10)
  end
  
  # GET /products/new
  def new
    return redirect_to new_store_profile_path, notice: 'Conclua seu Perfil.' unless profile_is_complete?(current_store)
    return redirect_to new_store_shipping_path, notice: 'Crie sua Politica de Entregas.' unless shipping_is_complete?(current_store)
    @product = current_store.products.build
  end

  # GET /products/1/edit
  def edit
  end
  
  # POST /products
  # POST /products.json
  def create
    @product = current_store.products.build(product_params)
    if @product.save
      redirect_to edit_store_product_path(@product), notice: 'Produto criado com sucesso.'
    else
      render :new
    end
  end
  
  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    if @product.update(product_params)
      redirect_to edit_store_product_path(@product), notice: 'Produto atualizado com sucesso.'
    else
      render :edit
    end
  end
  
  private

  def store_approved
    redirect_to edit_store_registration_path, notice: 'Aguarde a verificação dos Dados, isso pode levar até 2 dias úteis.' if current_store.status == 'disapprove'
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.friendly.find(params[:id])
    authorized_product
  end

  def authorized_product
    if current_store.id != @product.store.id
      redirect_to store_products_path, notice: 'Você não está autorizado a editar esse Produto.'
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def product_params 
    params.require(:product).permit(:subcategory_id, :store_category_id, :title, :price, :description, :weight,
      :thumbnail, :visibility, {images: []}, type_products_attributes: TypeProduct.attribute_names.map(&:to_sym).push(:_destroy))
  end
end
