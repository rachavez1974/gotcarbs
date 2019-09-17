class Item < ApplicationRecord
  @@current_menu = nil
  has_many :ordered_items
  has_many :orders, through: :ordered_items

  enum menu_type: [:Breakfast, :Lunch, :"Happy Hour", :Dinner, :"Late Night", :Brunch]
  enum section: [:Starters, :Classics, :Dishes, :"A La Carte", :Confections]
  VALID_PRICE_REGEX = /^\d{1,4}(\.\d{0,2})?$/

  validates :name, presence: true, length: {maximum: 75}
  validates :description, presence: true, length: {maximum: 500}
  validates :price, presence: true, numericality: {greater_than: 0.0},
                                    format: {with: VALID_PRICE_REGEX, multiline: true}
  validates :section, presence: true
  validates :menu_type, presence: true
  validates :availability, presence: true

  scope :menu_items, -> (menu_type) { where(menu_type: menu_type) }

  def self.find_by_id_or_name(key)
    Item.find_by(:id => key) || Item.find_by(:name => key)
  end

  def self.menu(specific_menu = nil)
    if ApplicationController.helpers.breakfast_time? && specific_menu == "0"
      @@current_menu = "Breakfast" 
      Item.where("menu_type = ?", 0) 
    elsif specific_menu == "0" 
      Item.where("menu_type = ?", 0)
    elsif ApplicationController.helpers.lunch_time? && specific_menu == "1"
      @@current_menu = "Lunch"
      Item.where("menu_type = ?", 1)
    elsif specific_menu == "1"
      Item.where("menu_type = ?", 1)
    elsif ApplicationController.helpers.dinner_time? && specific_menu == "3"
      @@current_menu = "Dinner"
      Item.where("menu_type = ?", 3)
    elsif specific_menu == "3"
      Item.where("menu_type = ?", 3)
    elsif ApplicationController.helpers.late_night_time? && specific_menu == "4"
      @@current_menu = "Late Night"
      Item.where("menu_type = ?", 4)
    elsif specific_menu == "4"
      Item.where("menu_type = ?", 4)
    elsif ApplicationController.helpers.brunch_time? && specific_menu == "5"
      @@current_menu = "Brunch"
      Item.where("menu_type = ?", 5)
    elsif specific_menu == "5"
      Item.where("menu_type = ?", 5)
    elsif specific_menu == '2'
      Item.where("menu_type = ?", 2)
    end
  end

  def self.current_menu_only
    if ApplicationController.helpers.breakfast_time?
      @@current_menu = "Breakfast" 
      Item.where("menu_type = ?", 0) 
    elsif ApplicationController.helpers.lunch_time?
      @@current_menu = "Lunch"
      Item.where("menu_type = ?", 1)
    elsif ApplicationController.helpers.dinner_time?
      @@current_menu = "Dinner"
      Item.where("menu_type = ?", 3)
    elsif ApplicationController.helpers.late_night_time?
      @@current_menu = "Late Night"
      Item.where("menu_type = ?", 4)
    elsif ApplicationController.helpers.brunch_time?
      @@current_menu = "Brunch"
      Item.where("menu_type = ?", 5)
    end
  end

  def self.current_menu
    @@current_menu
  end





end
