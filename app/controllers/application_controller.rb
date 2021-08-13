class ApplicationController < ActionController::Base
  include Pagy::Backend
  protect_from_forgery with: :exception
  include CurrentCart
  include CurrentAddressClient
  before_action :set_cart, :set_address_client
  before_action :detect_mobile

  private

  def after_sign_out_path_for(resource)
    root_path
  end

  def detect_mobile
    request.variant = :mobile if request.user_agent =~ /Mobile|webOS|iPhone/
  end
end
