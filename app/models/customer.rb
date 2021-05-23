class Customer < ApplicationRecord
  attr_accessor :first_name, :last_name
  validates :first_name, :last_name, presence: true
  has_many :invoices
  has_many :merchants, through: :invoices
end
