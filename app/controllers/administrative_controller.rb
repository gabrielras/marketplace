class AdministrativeController < ApplicationController
  include Pagy::Backend
  before_action :authenticate_admin!
end
