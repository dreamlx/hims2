class Order < ActiveRecord::Base
  validates :investable, presence: true
  validates :product_id, presence: true
  validates :amount, numericality: true
  validates :amount, numericality: {greater_than_or_equal_to: 0.01}, on: :create
  belongs_to :investable, polymorphic: true
  belongs_to :product
  belongs_to :user

  mount_uploader :other, ImageUploader

  after_create :after_create

  def after_create
    update(user_id: self.investable.user_id, booking_date: self.created_at)
  end
end
