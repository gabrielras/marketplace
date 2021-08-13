class TypeProduct < ApplicationRecord
  belongs_to :product

  before_save :at_least_one_type

  def at_least_one_type
    if size.blank? && color.blank?
      errors.add(:base, 'Digite pelo menos uma cor ou tamanho.')
      raise ActiveRecord::Rollback
    end
  end
end
