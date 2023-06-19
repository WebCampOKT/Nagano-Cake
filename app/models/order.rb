class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details, dependent: :destroy

  enum payment: ["クレジットカード", "銀行振込"]
end
