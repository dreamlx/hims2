class Roi < ActiveRecord::Base
  validates :product_id, presence: true
  validates :range, presence: true
  validates :profit, presence: true
  belongs_to :product
end
