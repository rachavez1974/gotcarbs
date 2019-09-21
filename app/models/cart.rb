class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items
  has_many :items, through: :cart_items

  TAX = 0.1

  def subtotal
    sum = 0
    self.cart_items.each do |cart_item|
      sum+= cart_item.item.price
    end
    return sum
  end

  def tax
    (subtotal * TAX).round(2)
  end

  def total
    subtotal + tax
  end
end
