class Pagarme::CreateTransactionService
  require 'pagarme'

  PagarMe.api_key        = ENV['PAGARME_API_KEY']
  PagarMe.encryption_key = ENV['PAGARME_ENCRYPTION_KEY']

  def initialize(params)
    @paymnet_info = params[:paymnet_info],
    @order = params[:order]
  end

  def call
    @default_delivery_time = (Time.current + (@order.cart.delivery_time.to_i).days).strftime("%Y-%m-%d")
    @items = []
      @order.cart.order_products.each do |order_product|
        @items << {
          id: order_product.product_id.to_s,
          title: order_product.product.title,
          unit_price: order_product.price_paid.to_i*100,
          quantity: order_product.quantity.to_i,
          tangible: true
        }
    end
    transaction  = PagarMe::Transaction.new({
      amount: @order.cart.total_price_paid_with_shipping.to_i*100,
      payment_method: "credit_card",
      card_number: @paymnet_info.first[:card_number].gsub(/[^0-9]/, ''),
      card_holder_name: @paymnet_info.first[:card_holder_name],
      card_expiration_date: @paymnet_info.first[:card_expiration_date].gsub(/[^0-9]/, ''),
      card_cvv: @paymnet_info.first[:card_cvv].gsub(/[^0-9]/, ''),
      postback_url: "https://reccebi.herokuapp.com/client/get_payment_status",
      capture: true,
      installments: @paymnet_info.first[:installment_payment],
      customer: {
        external_id: "##{@order.id}",
        name: @order.client.name,
        type: "individual",
        country: "br",
        email: @order.client.email,
        documents: [
          {
            type: "cpf",
            number: @order.client.cpf_number.gsub(/[^0-9]/, '')
          }
        ],
        phone_numbers: ["+55" + @paymnet_info.first[:phone_number].gsub(/[^0-9]/, '')]
      },
      billing: {
        name: @order.client.name,
        address: {
            country: "br",
            state: @order.cart.address_client.state,
            city: @order.cart.address_client.city,
            neighborhood: @order.cart.address_client.neighborhood,
            street: @order.cart.address_client.street,
            street_number: @order.cart.address_client.number_residence,
            zipcode: @order.cart.address_client.number_cep.tr('-', '')
        }
      },
      shipping: {
        name: @order.store.title,
        fee: @order.cart.price_shipping.to_i*100,
        delivery_date: @default_delivery_time,
        expedited: true,
        address: {
            country: "br",
            state: @order.store.shipping.state,
            city: @order.store.shipping.city,
            neighborhood: @order.store.shipping.neighborhood,
            street: @order.store.shipping.street,
            street_number: @order.store.shipping.number_residence,
            zipcode: @order.store.shipping.number_cep.tr('-', '')
        }
      },
      items: @items,
      split_rules:[
        {
          liable: true,
          charge_processing_fee: true,
          percentage: "100",
          charge_remainder_fee: true,
          recipient_id: @order.store.profile.recipient_id,
        }
      ]
    })
    begin
      transaction.charge
      @order.update(transaction_id: transaction.id, status: transaction.status)
    rescue
      @order.update(status: 'error_in_transaction')
    end
  end

end
