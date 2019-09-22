class CartItem < ApplicationRecord
  belongs_to :item
  belongs_to :cart

  validates :quantity, presence: true, numericality: {greater_than: 0}
end
