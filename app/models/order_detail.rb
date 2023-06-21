class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :item

  enum product_status: {impossible: 0, waiting: 1, production: 2, completion: 3}

  def subtotal
    self.item.add_tax_price.to_i * self.quantity.to_i
  end
end
