class User < ApplicationRecord

  validates_presence_of :name, :street_address, :city, :state, :zip
  validates :email, uniqueness: true, presence: true
  has_many :orders

  has_secure_password

  enum role: %w(reg admin merch_employee merch_admin)
end
