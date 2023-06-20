class Item < ApplicationRecord
  has_many :cart_items
  has_many :order_details
  belongs_to :genre
  has_many :orders, through: :order_details

  has_one_attached :image

  validates :name, presence: true
  validates :caption, presence: true
  validates :genre, presence: true
  validates :price, presence: true

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join("app/assets/images/no_image.png")
      image.attach(io: File.open(file_path), filename: "no_image.png", content_type: "image/png")
    end
    image.variant(resize_to_limit: [width, height]).processed
  end

  def add_tax_price
    tax = 1.1
    (self.price * tax).to_i
  end
end
