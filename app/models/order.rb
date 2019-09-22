class Order < ApplicationRecord
  TAX = 0.1

  before_save :subtotal, :tax, :total
  belongs_to :user
  has_many :ordered_items
  has_many :items, through: :ordered_items

  default_scope -> { order(created_at: :desc) }
  scope :user_orders, ->(id) { where(user_id: id) }
  
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
