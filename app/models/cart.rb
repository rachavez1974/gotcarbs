class Cart < ApplicationRecord
  belongs_to :user
  has_many :ordered_items
  has_many :items, through: :ordered_items

  def sub_total
    sum = 0
    self.ordered_items.each do |ordered_item|
      sum+= ordered_item.total_price
    end
    return sum
  end
end
