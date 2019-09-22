module Calculable

  def subtotal
    sum = 0
    self.cart_items.each do |cart_item|
      sum+= cart_item.item.price * cart_item.quantity
    end
    return sum
  end

  def tax
    (self.subtotal * TAX).round(2)
  end

  def total
    self.subtotal + tax
  end
end