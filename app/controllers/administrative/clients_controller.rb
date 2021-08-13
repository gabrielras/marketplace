class Administrative::ClientsController < AdministrativeController
  def index
    @q = Client.search(params[:q])
    @clients = @q.result
    @pagy, @clients = pagy(@clients, page: params[:page], items: 15)
  end

  def login
    client = Client.find(params[:id])
    sign_in_and_redirect client
  end
end
  