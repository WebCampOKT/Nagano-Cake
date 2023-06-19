class CartItem < ApplicationRecord
  belongs_to :item
  belongs_to :customer

  def subtotal
    self.item.add_tax_price.to_i * self.quantity.to_i
  end

  def total_price
    total_price += self.subtotal
  end
end
