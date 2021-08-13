class AddressClient < ApplicationRecord
  belongs_to :cart

  def complete?
   return true if number_cep.present? && neighborhood.present? && street.present? && number_residence.present? 
   false
  end

  def address_text
    text = neighborhood + ', ' + street + ', ' + number_residence
    text = text + ', ' + complement if complement.present?
    return text
  end
end
