class Individual < ActiveRecord::Base
  ID_TYPES = ["身份证","营业执照","护照","香港永久性居住身份证","台胞证","港澳同胞回乡证","驾照"]
  validates :name, presence: true
  validates :cell, presence: true
  validates :id_type, inclusion: ID_TYPES, allow_blank: true

  belongs_to :user

  mount_uploader :id_front, ImageUploader
  mount_uploader :id_back, ImageUploader
end