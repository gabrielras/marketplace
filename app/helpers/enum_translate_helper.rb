module EnumTranslateHelper

  def translate_product_status(status)
    case status
    when 'disapprove'
      'Desaprovado' 
    when 'approved'
      'Aprovado'
    end
  end

  def translate_type_payment(payment)
    case payment
    when 'credit_or_debit_card_payment_machine'
      'Cartão de Crédito' 
    when 'cash_payment'
      'Dinheiro'
    when 'transfer_payment'
      'Transferência Bancária'
    when 'billet_payment'
      'Boleto'
    end
  end

  def translate_type_shipping(shipping)
    case shipping
    when 'daily_delivery'
      'Receba Hoje' 
    when 'weekly_delivery'
      'Entrega em dia específico da semana'
    when 'reserve_delivery'
      'Encomendar'
    when 'pick_up_at_the_store'
      'Retirar na Loja'
    end
  end

  def translate_discount_status(status)
    case status
    when 'time_reached'
      'Tempo encerrado'
    when 'active'
      'Ativo'
    end
  end

  def translate_store_payment(payment)
    case payment
    when 'free'
      'Perído de Teste' 
    when 'peding'
      'Pagamento Pendente'
    when 'paid'
      'Pago'
    end
  end
end
