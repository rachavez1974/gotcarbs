class OrderedItem < ApplicationRecord
  belongs_to :item
  belongs_to :order

  validates :quantity, presence: true, numericality: {greater_than: 0.0}

  def total_price
    self.quantity * self.item.price
  end
end
