class Product < ActiveRecord::Base
  validates :fund_id, presence: true
  validates :name, presence: true
  validates :desc, presence: true
  validates :progress_bar, numericality: {greater_than_or_equal_to: 0, less_than_or_equal_to: 100}
  belongs_to :fund
end
