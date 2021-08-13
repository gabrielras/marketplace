class ProductsController < ApplicationController
  before_action :set_product, only: [:show]
  before_action :set_store, only: [:store]

  def show
    if @product.visibility == 'false' ||  !@product.store_valid?
      return redirect_to root_path, notice: 'O Produto está indisponível.' 
    end
    @type_products = []
    @product.type_products.each do |type_product|
      if type_product.visibility
        @type_products << type_product.color + ' - ' + type_product.size
      end
    end
    @recommendations = Product.where(store_id: @product.store_id)
                              .where.not(id: @product.id)
                              .limit(4)
  end
  
  private

  def set_product
    @product = Product.friendly.find(params[:id])
  end

end
