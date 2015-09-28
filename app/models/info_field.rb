class InfoField < ActiveRecord::Base
  FIELD_TYPES = ["string", "text", "photo"]
  validates :field_type, inclusion: FIELD_TYPES
  belongs_to :product
end
