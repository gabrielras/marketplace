class Client::AddressClientsController < ApplicationController
  before_action :authorized_address_client

  def edit
  end

  def update
    if @address_client.update(address_client_params)
      redirect_to new_client_order_path, notice: 'Seu endereço foi adicionado.'
    else
      redirect_to edit_client_address_client_path(@address_client), notice: 'Não foi possível atualizar, tente novamente.'
    end
  end

  private

  def authorized_address_client
    if AddressClient.find(params[:id]) != @cart.address_client
      redirect_to edit_client_address_client_path(@address_client), notice: 'Não é mais possível alterar essa localização.'
    end
  end

  def address_client_params
    params.require(:address_client).permit(:number_cep, :state, :city, :neighborhood,
    :street, :number_residence, :complement)
  end
    
end
  