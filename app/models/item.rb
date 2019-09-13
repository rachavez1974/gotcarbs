class Item < ApplicationRecord
  has_many :ordered_items
  has_many :orders, through: :ordered_items

  enum menu_type: [:Breakfast, :Lunch, :"Happy Hour", :Dinner, :"Late Night", :Brunch]
  enum section: [:Starters, :Classics, :Dishes, :A_La_Carte, :Confections]
  VALID_PRICE_REGEX = /^\d{1,4}(\.\d{0,2})?$/

  validates :name, presence: true, length: {maximum: 75}
  validates :description, presence: true, length: {maximum: 500}
  validates :price, presence: true, numericality: {greater_than: 0.0},
                                    format: {with: VALID_PRICE_REGEX, multiline: true}
  validates :section, presence: true
  validates :menu_type, presence: true
  validates :availability, presence: true

  scope :menu_items, -> (menu_type) { where(menu_type: menu_type) }
  scope :menu_item, -> (key_search) { where("id = ? OR name = ?", key_search) }



  private

end
