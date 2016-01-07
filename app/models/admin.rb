class Admin < ActiveRecord::Base
  has_secure_password
  validates :name, presence: true
  validates :name, uniqueness: true
  validates :password, presence: true, length: {minimum: 6}
end
