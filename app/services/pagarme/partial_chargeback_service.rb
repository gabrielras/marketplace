class Pagarme::PartialChargebackService
  require 'pagarme'

  PagarMe.api_key        = ENV['PAGARME_API_KEY']
  PagarMe.encryption_key = ENV['PAGARME_ENCRYPTION_KEY']

  def initialize(params)
    @order_product = params[:order_product],
    @response_split = params[:response_split]
  end

  def call
    transaction = PagarMe::Transaction.find_by_id(@order_product.first.cart.order.transaction_id)

    transaction.refund({
    async: false,
    amount: @order_product.first.return_cashback_for_client,
    split_rules:[
      {
        id: @response_split.first.id,
        amount: @order_product.first.return_cashback_for_client.to_s,
        recipient_id: @order_product.first.cart.order.store.profile.recipient_id,
        charge_processing_fee: true
      }
    ]
    })
  end

end
