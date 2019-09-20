class Order < ApplicationRecord
  belongs_to :user
  # has_one :cart
  # has_many :ordered_items, dependent: :destroy
  # has_many :items, through: :ordered_items

end
