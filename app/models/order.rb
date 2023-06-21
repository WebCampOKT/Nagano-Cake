class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details, dependent: :destroy
  has_many :items, through: :order_details

  enum status: {payment_waiting: 0, payment_confermation: 1, production: 2, shipping_preparation: 3, sent: 4}
  enum payment: {credit_card: 0, transfer: 1}

  validates :postal_code, presence: true
  validates :address, presence: true
  validates :name, presence: true

  def const_shipping_cost
    self.shipping_cost = 800
  end
end
