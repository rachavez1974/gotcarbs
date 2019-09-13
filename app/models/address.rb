class Address < ApplicationRecord
  belongs_to :user
  has_many :users

  enum address_type: [:Business, :Military, :Residence, :University]
  enum unit_type: [:None, :Apt, :Floor, :Suite]

  validates  :street_address, presence: true, length: {maximum: 150}
  validates  :address_type, presence: true
  validates  :unit_type, presence: true
  validates  :number, presence: true, if: :unit_type_not_none?
  validates  :city, presence: true, length: {in: 2..50}
  validates  :state, presence: true, length: {in: 2..50}
  validates  :zipcode, presence: true, length: {maximum: 5}

  scope :user_addresses, -> (user_id) { where(user_id: user_id) }

  def unit_type_not_none?
    return true if unit_type != "None"
  end

end
