class Administrative::StoresController < AdministrativeController
  def index
    @q = Store.search(params[:q])
    @stores = @q.result
    @pagy, @stores = pagy(@stores, page: params[:page], items: 15)
  end

  def login
    store = Store.find(params[:id])
    sign_in_and_redirect store
  end
end
  