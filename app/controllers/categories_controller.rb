class CategoriesController < ApplicationController
  include CartHelper
  before_action :set_category
  
  def show
    @q = Product.search(params[:q])
    @products = @q.result.includes(:store, :subcategory)
                         .where(subcategories: {category_id: @category.id})
                         .where(visibility: 'true')
                         .where(stores: {status: 'valid'})
    if params[:q].blank?
      session[:city] = "Fortaleza"
    else
      session[:city] = params[:q][:store_profile_city_cont]
    end
    @products = @products.joins(:profile).where(profiles: {city: session[:city]})
    @pagy, @products = pagy(@products, page: params[:page], items: 10)
  end

  private

    def set_category
      @category = Category.find(params[:id])
    end
end
