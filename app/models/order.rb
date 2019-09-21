class Order < ApplicationRecord

  before_save :subtotal, :tax, :total
  belongs_to :user
  # has_many :cart_items
  has_many :ordered_items
  has_many :items, through: :ordered_items

  TAX = 0.1

  def subtotal
    sum = 0
    self.ordered_items.each do |order_item|
      sum+= order_item.item.price * order_item.quantity
    end
    self.subtotal = sum
  end

  def tax
    self.tax = (subtotal * TAX).round(2)
  end

  def total
    self.total = subtotal + tax
  end

end
