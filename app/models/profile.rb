class Profile < ApplicationRecord
  belongs_to :store
 
  before_save :at_least_one_payment_type, :phone_number_corrector, :link_valid

  validates :cep_number, presence: true
  validates :state, presence: true
  validates :city, presence: true
  validates :street, presence: true
  validates :neighborhood, presence: true
  validates :number_residence, presence: true
  validates :phone_number_whatsapp, presence: true
  validates :thumbnail, presence: true
  mount_uploader :thumbnail, ThumbnailUploader 

  def phone_number_corrector
    if [11].exclude? self.phone_number_whatsapp.gsub(/[^0-9]/, '').length
      errors.add(:base, 'Seu número deve estar no formato (99) 99999-9999.')
      raise ActiveRecord::Rollback
    end
  end
 
  def at_least_one_payment_type
    if credit_or_debit_card_payment_machine.blank? && cash_payment.blank? && billet_payment.blank? && transfer_payment.blank?
      errors.add(:base, 'Selecione pelo menos um tipo de pagamento.')
      raise ActiveRecord::Rollback
    end
  end

  def address_text
    text = city + ', ' + neighborhood + ', ' + street + ', ' + number_residence
    text = text + ', ' + complement if complement.present?
    return text
  end

  def link_valid
    if link_to_facebook.present?
      if link_to_facebook.exclude?("https://www.facebook.com") 
        errors.add(:base, 'O link deve estar no formato: https://www.facebook.com/exemplo')
        raise ActiveRecord::Rollback
      end
    end
    
    if link_to_instagram.present?
      if link_to_instagram.exclude?("https://www.instagram.com")
        errors.add(:base, 'O link deve estar no formato: https://www.instagram.com/exemplo')
        raise ActiveRecord::Rollback
      end
    end
  end

end
