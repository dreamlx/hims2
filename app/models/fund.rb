class Fund < ActiveRecord::Base
  validates :name, presence: true
  validates :desc, presence: true
  validates :progress_bar, numericality: {greater_than_or_equal_to: 0, less_than_or_equal_to: 100}

  has_many :products, dependent: :destroy
end
