class Store < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  extend FriendlyId
  friendly_id :title, use: :slugged
  
  #before_save :cpf_valid?
  after_create :payment_create

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  validates :surname, presence: true
  validates :title, presence: true, uniqueness: true

  has_many :orders, dependent: :destroy
  has_many :products, dependent: :destroy
  has_one :profile, dependent: :destroy
  has_one :shipping, dependent: :destroy
  has_one :payment, dependent: :destroy

  def cpf_valid?
    unless CPF.valid?(cpf_number)
      errors.add(:base, 'O número do CPF está incorreto.')
      raise ActiveRecord::Rollback
      return
    end
  end

  def subcategories_list
    Subcategory.joins(:products).where(products: {store_id: id}).distinct if Product.where(store_id: id , store_category_id: nil)
  end

  def store_categories_list
    StoreCategory.joins(:products).where(products: {store_id: id}).distinct
  end

  def payment_create 
    self.update(status: 'valid')
    Payment.create(store_id: self.id)
  end

  def store_valid?
    return true if status == 'valid'
    false
  end
end
