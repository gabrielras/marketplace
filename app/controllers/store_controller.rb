class StoreController < ApplicationController
  include Pagy::Backend
  before_action :authenticate_store!, :destroy_cart

  def destroy_cart
    @cart.destroy if @cart.present?
  end
end
  