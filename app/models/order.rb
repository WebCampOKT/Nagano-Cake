class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details, dependent: :destroy

  enum status: {payment_waiting: 0, payment_confermation: 1, production: 2, shipping_preparation: 3, sent: 4}
  enum payment: ["クレジットカード", "銀行振込"]

  def total
    self.order_details.subtotal.sum
  end

  def const_shipping_cost
    self.shipping_cost = 800
  end

  def total_price
    self.total.to_i + self.const_shipping_cost.to_i
  end
  
  def full_addresses
    current_customer.shipping_addresses.postal_code + current_customer.shipping_addresses.address + current_customer.shipping_addresses.name
  end
end
