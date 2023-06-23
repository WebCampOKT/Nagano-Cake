class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # 退会してなければtrueを返す
  def active_for_authetication?
    super && (is_active == true)
  end


  has_many :cart_items, dependent: :destroy
  has_many :shipping_addresses, dependent: :destroy
  has_many :orders, dependent: :destroy

  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true
  validates :first_name_kana, presence: true
  validates :postal_code, presence: true
  validates :address, presence: true
  validates :phone_number, presence: true

  def self.looks(search, word)
    @customer = Customer.where(["first_name LIKE? OR last_name LIKE? OR first_name_kana LIKE? OR last_name_kana LIKE?", "%#{word}%", "%#{word}%", "%#{word}%", "%#{word}%"])
  end
end
