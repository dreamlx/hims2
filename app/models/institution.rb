class Institution < ActiveRecord::Base
  validates :name, presence: true
  validates :cell, presence: true

  belongs_to :user

  mount_uploader :business_licenses, ImageUploader
end
