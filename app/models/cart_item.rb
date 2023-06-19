class CartItem < ApplicationRecord
  belongs_to :item
  belongs_to :customer

  validates :quantity, presence: true
  
  def subtotal
    self.item.add_tax_price.to_i * self.quantity.to_i
  end
  
  def self.cart_items_total_price(cart_items)
    array = []
    cart_item.each do |cart_product|
      array << cart_item.product.price * cart_item.amount
    end
  　return (array.sum * 1.1).floor
  end 

end
