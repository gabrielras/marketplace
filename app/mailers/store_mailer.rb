class StoreMailer < ApplicationMailer
  
  def send_order_status_canceled(order)
    @order = order
    mail(to: @order.store.email, subject: 'Pedido Cancelado!')
  end

  def send_order_status_requested(order)
    @order = order
    mail(to: @order.store.email, subject: 'Pedido Solicitado!')
  end
end
