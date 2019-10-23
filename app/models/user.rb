class User < ApplicationRecord

  validates_presence_of :name, :street_address, :city, :state, :zip
  validates_presence_of :password, require: true
  validates :email, uniqueness: true, presence: true

  has_secure_password

  enum role: %w(reg admin merch_employee merch_admin)
end
