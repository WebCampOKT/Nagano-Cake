class CartItem < ApplicationRecord
  belongs_to :item
  belongs_to :customer
  
  validates :quantity, presence: true
  
  def subtotal
    self.item.add_tax_price.to_i * self.quantity.to_i
  end
end
