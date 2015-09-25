class Institution < ActiveRecord::Base
  validates :name, presence: true
  validates :cell, presence: true

  belongs_to :user
  has_many :orders

  mount_uploader :business_licenses, ImageUploader
end
