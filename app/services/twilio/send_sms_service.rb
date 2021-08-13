class Twilio::SendSmsService
  require 'twilio-ruby'

  def initialize(params)
    @order = params[:order]
    @account_sid = ENV['TWILIO_ACCOUNT_SID']
    @auth_token = ENV['TWILIO_AUTH_TOKEN']
    @client = Twilio::REST::Client.new @account_sid, @auth_token
  end

  def wait_for_client_confirmation
    @client.messages.create(
      from: '+5585996813635',
      to: @order.phone_number,
      body: "a nupreço agradece, seu código é: #{@order.confirmation_code}."
    )
  end

  def confirm_order_for_store
    @client.messages.create(
      from: '+5585996813635',
      to: @order.store.phone_number,
      body: "Novo Pedido, número do pedido: #{@order.transaction_id}, acesse mais informações na nossa plataforma."
    )
  end

  def order_canceled_by_client
    @client.messages.create(
      from: '+5585996813635',
      to: @order.store.phone_number,
      body: "Infelizmente o pedido: #{@order.transaction_id} foi cancelado."
    )
  end
end
