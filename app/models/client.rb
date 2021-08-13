class Client < ApplicationRecord
  require 'cpf_cnpj'
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  #before_save :cpf_valid?

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true

  has_many :orders
  has_many :order_products
  has_many :reviews

  def cpf_valid?
    unless CPF.valid?(cpf_number)
      errors.add(:base, 'O número do CPF está incorreto.')
      raise ActiveRecord::Rollback
      return
    end
  end

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end
end
