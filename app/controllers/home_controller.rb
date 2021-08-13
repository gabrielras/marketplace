class HomeController < ApplicationController
  include CartHelper
  include EnabledStore

  before_action :set_store, only: [:show]

  def index
    @q = Product.ransack(params[:q])
    @products = @q.result.includes(:store, :subcategory)
                            .where(visibility: 'true')
                            .where(stores: {status: 'valid'})
    if params[:q].blank?
      if session[:city].blank?
        session[:city] = "Fortaleza"
      end
    else
      session[:city] = params[:q][:store_profile_city_cont]
    end
    @products = @products.joins(:profile, :shipping).where(profiles: {city: session[:city]})
    @pagy, @products = pagy(@products, page: params[:page], items: 15)
  end

  def show
    if @store.profile.blank? || @store.shipping.blank? || !@store.store_valid?
      if current_store.present?
        return redirect_to new_store_profile_path, notice: 'Conclua seu Perfil.' unless profile_is_complete?(current_store)
        return redirect_to new_store_shipping_path, notice: 'Crie sua Politica de Entregas.' unless shipping_is_complete?(current_store)
      end
      return redirect_to root_path, notice: 'Essa loja não está disponível'
    end
    @q = Product.search(params[:q])
    @products = @q.result.includes(:store, :subcategory).where(store_id: @store.id, visibility: 'true')
    @pagy, @products = pagy(@products, page: params[:page], items: 15)
  end

  private

  def set_store
    @store = Store.friendly.find(params[:slug])
  end
end
  