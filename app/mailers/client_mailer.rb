class ClientMailer < ApplicationMailer

  def send_order_status_pending(order)
    @order = order
    mail(to: @order.cart.client.email, subject: 'Confirme seu pedido :)')
  end

  def send_order_status_refused(order)
    @order = order
    mail(to: @order.cart.client.email, subject: 'Seu pedido foi recusado infelizmente :(')
  end
end
