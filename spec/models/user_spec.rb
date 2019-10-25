require 'rails_helper'

describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :street_address }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip }
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
    it { should validate_presence_of :password }
  end

  describe 'relationship' do
    it { should have_many :orders }
  end

  describe 'roles' do
    it "can be created as a default user" do
      user = User.create(name: "Bob G",
                          street_address: "123 Avenue",
                          city: "Portland",
                          state: "OR",
                          zip: "30203",
                          email: "bobg@agency.com",
                          password: "bobg",
                          password_confirmation: "bobg",
                          role: 0
                          )

      expect(user.role).to eq("reg")
    end

    it "can be created as an admin user" do
      user = User.create(name: "Bob G",
                          street_address: "123 Avenue",
                          city: "Portland",
                          state: "OR",
                          zip: "30203",
                          email: "bobg@agency.com",
                          password: "bobg",
                          password_confirmation: "bobg",
                          role: 1
                          )

      expect(user.role).to eq("admin")
    end

    it "can be created as a merchant employee user" do
      user = User.create(name: "Bob G",
                          street_address: "123 Avenue",
                          city: "Portland",
                          state: "OR",
                          zip: "30203",
                          email: "bobg@agency.com",
                          password: "bobg",
                          password_confirmation: "bobg",
                          role: 2
                          )

      expect(user.role).to eq("merch_employee")
    end

    it "can be created as a merchant admin user" do
      user = User.create(name: "Bob G",
                          street_address: "123 Avenue",
                          city: "Portland",
                          state: "OR",
                          zip: "30203",
                          email: "bobg@agency.com",
                          password: "bobg",
                          password_confirmation: "bobg",
                          role: 3
                          )

      expect(user.role).to eq("merch_admin")
    end
  end
end
