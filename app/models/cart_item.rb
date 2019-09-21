class CartItem < ApplicationRecord
  belongs_to :item
  belongs_to :cart

  validates :quantity, presence: true, numericality: {greater_than: 0}

  def self.subtotal
    sum = 0
      self.cart_items.each do |cart_item|
        sum+= cart_item.price
      end
    return sum
  end

  def tax
    
  end

  def total
    
  end
end
