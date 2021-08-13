class Pagarme::CaptureTransactionService
  require 'pagarme'

  PagarMe.api_key        = ENV['PAGARME_API_KEY']
  PagarMe.encryption_key = ENV['PAGARME_ENCRYPTION_KEY']

  def initialize(params)
    @order = params[:order]
  end

  def call
    transaction = PagarMe::Transaction.find_by_id(@order.transaction_id)
    transaction.capture({:amount => @order.cart.current_total_price.to_i*100})
  end
end
