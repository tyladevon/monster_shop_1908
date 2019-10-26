class User < ApplicationRecord

  validates_presence_of :name, :street_address, :city, :state, :zip
  validates :email, uniqueness: true, presence: true
  has_many :orders
  belongs_to :merchant, optional: true

  has_secure_password

  enum role: %w(reg admin merch_employee merch_admin)
end
