class Product < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :subcategory
  belongs_to :store
  belongs_to :store_category, optional: true
  has_many :reviews
  has_many :products_discounts, dependent: :destroy
  has_many :discounts, :through => :products_discounts
  has_many :order_products
  has_many :type_products
  accepts_nested_attributes_for :type_products, reject_if: :all_blank, allow_destroy: true

  has_one :profile, -> {distinct}, through: :store
  has_one :shipping, -> {distinct}, through: :store

  before_destroy :destroy_valid
  before_create :product_valid
  before_save :product_invisibility, :image_size

  validates :thumbnail, presence: true
  validates_length_of :images, maximum: 3
  validates_associated :subcategory
  validates_associated :store
  validates :title, presence: true
  validates :price, presence: true
  validates :description, presence: true

  mount_uploaders :images, ImageUploader
  mount_uploader :thumbnail, ThumbnailUploader

  enum visibility: { 
    true: 0,
    false: 1
  }

  def image_size
    if self.thumbnail.present?
      if self.thumbnail.size > 4000.kilobyte
        errors.add(:base, 'A imagem principal deve ter tamanho máximo de 4mb. Faça a compressão da imagem.')
        raise ActiveRecord::Rollback
      end
    end

    if self.images.present?
      self.images.each do |image|
        if image.size > 4000.kilobyte
          errors.add(:base, 'As imagens secundárias devem ter tamanho máximo de 4mb. Faça a compressão da imagens.')
          raise ActiveRecord::Rollback
        end
      end
    end
  end

  def discount_select
    return discounts.find { |discount| discount.status == 'active' && discount.start_time < Time.current && discount.end_time > Time.current } if discounts.present?
  end

  def reviews_value_total
    reviews&.average(:value)
  end

  def product_invisibility
    self.update(visibility: 'false') if quantity <= 0
  end

  def product_valid
    if price < 1
      errors.add(:base, 'O valor deve ser maior que 1 real.')
      raise ActiveRecord::Rollback
    end

    if quantity < 1
      errors.add(:base, 'A quantidade minima é uma unidade.')
      raise ActiveRecord::Rollback
    end
  end

  def destroy_valid
    if order_products.present?
      errors.add(:base, 'Já existe um pedido em andamento')
      raise ActiveRecord::Rollback
    end
  end

  def store_valid?
    return true if store.status == 'valid'
    false
  end
end
