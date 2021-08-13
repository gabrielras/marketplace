module ApplicationHelper
  include Pagy::Frontend

  def link_to_add_row(name, f, association, **args)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize, f: builder)
    end
    link_to(name, '#', class: "add_fields " + args[:class], data: {id: id, fields: fields.gsub("\n", "")})
  end

  def cart_count_over_one
    return total_cart_order_products if total_cart_order_products >= 0
  end
    
  def total_cart_order_products
    return 0 if @cart.blank?
    total = @cart.order_products.map(&:quantity).sum
    return total if total >= 0
  end

  def free_shipping(product)
    return false unless current_client.present?
    if product.store.select_shipping.shipping_price_for_location(@address_client.city, @address_client.neighborhood, product.weight) <= 0
      return true
    end
    return false
  end
end
