class Store::StoreCategoriesController < StoreController
  include EnabledStore
  before_action :set_store_category, only: [:edit, :update, :destroy]
  before_action :store_approved, only: [:edit, :new, :create, :update]

  # GET /store_categories
  # GET /store_categories.json
  def index
    @q = StoreCategory.search(params[:q])
    @store_categories = @q.result.where(:store_id => current_store.id)
                          .order('created_at DESC')
    @pagy, @store_categories = pagy(@store_categories, page: params[:page], items: 10)
  end
  
  # GET /store_categories/new
  def new
    return redirect_to new_store_profile_path, notice: 'Conclua seu Perfil.' unless profile_is_complete?(current_store)
    return redirect_to new_store_shipping_path, notice: 'Crie sua Politica de Entregas.' unless shipping_is_complete?(current_store)
    @store_category = StoreCategory.new
  end

  # GET /store_categories/1/edit
  def edit
  end
  
  # POST /store_categories
  # POST /store_categories.json
  def create
    @store_category = StoreCategory.new(store_category_params)
    if @store_category.save
      redirect_to edit_store_store_category_path(@store_category), notice: 'Categoria criado com sucesso.'
    else
      render :new
    end
  end
  
  # PATCH/PUT /store_categories/1
  # PATCH/PUT /store_categories/1.json
  def update
    if @store_category.update(store_category_params)
      redirect_to edit_store_store_category_path(@store_category), notice: 'Categoria atualizado com sucesso.'
    else
      render :edit
    end
  end

  def destroy
    @story_category.destroy
    redirect_to store_store_categories_path, notice: 'Categoria Deletada.'
  end
  
  private

  def store_approved
    redirect_to edit_store_registration_path, notice: 'Aguarde a verificação dos Dados, isso pode levar até 2 dias úteis.' if current_store.status == 'disapprove'
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_store_category
    @store_category = StoreCategory.find(params[:id])
    authorized_category
  end

  def authorized_category
    if current_store.id != @store_category.store.id
      redirect_to store_store_categories_path, notice: 'Você não está autorizado a editar esse Produto.'
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def store_category_params 
    params.require(:store_category).permit(:title).merge(store_id: current_store.id)
  end
end
