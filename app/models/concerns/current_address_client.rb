module CurrentAddressClient
  private

  def set_address_client
    return @address_client = AddressClient.find(session[:address_client_id])
  rescue ActiveRecord::RecordNotFound
    return nil
  end
end
