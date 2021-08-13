class Store::ProfilesController < StoreController
  before_action :set_profile, only: [:show, :edit, :update]
  before_action :set_payment

  def index
    @profile = Store.find(current_store.id).profile
    if (@profile != nil) 
      return redirect_to edit_store_profile_path(@profile) 
    end
    redirect_to new_store_profile_path
  end

  # GET /profile/1
  # GET /profile/1.json
  def show
    redirect_to edit_store_profile_path(@profile)
  end
  
  # GET /profile/new
  def new
    @profile = Store.find(current_store.id).profile
    if (@profile != nil) 
      return redirect_to edit_store_profile_path(@profile) 
    end
    @profile = Profile.new
  end
  
  # GET /profile/1/edit
  def edit
  end
  
  # POST /profile
  # POST /profile.json
  def create
    @profile = Profile.new(profile_params)
    if @profile.save 
      redirect_to new_store_shipping_path, notice: 'Perfil salvo com sucesso. Crie seus Dados de Envio.'   
    else
      render :new
    end
  end
  
  # PATCH/PUT /profile/1
  # PATCH/PUT /profile/1.json
  def update
    if @profile.update_attributes(profile_params)
      redirect_to edit_store_profile_path(@profile), notice: 'Perfil salvo com sucesso.'
    else
      render :edit
    end
  end
  
  private

    def set_profile
      @profile = Profile.find(params[:id])
      authorized_profile 
    end

    def set_payment
      @payment = Payment.find_by(store_id: current_store.id)
    end

    def authorized_profile
      if current_store.id != @profile.store.id
        redirect_to new_store_profile_path, notice: 'Você não está autorizado a editar esse Perfil.'
      end
    end

    def profile_params
      params.require(:profile).permit( :cep_number, :state, :city, :neighborhood, :street, :number_residence,
       :complement, :thumbnail, :phone_number_whatsapp, :link_to_facebook, :link_to_instagram, :credit_or_debit_card_payment_machine, 
       :cash_payment, :billet_payment, :transfer_payment).merge(store_id: current_store.id)
    end
end
 