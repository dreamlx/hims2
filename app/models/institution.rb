class Institution < ActiveRecord::Base
  HEADERS = ["id", "user_id", "name", "cell", "remark_name", "organ_reg", "business_licenses", "remark", "created_at", "updated_at"]
  validates :user_id, presence: true
  validates :name, presence: true
  validates :cell, presence: true

  belongs_to :user
  has_many :orders, as: :investable

  mount_uploader :business_licenses, ImageUploader

  def booking_orders
    orders.where('state=? OR state=?', '已预约', '已报单' )
  end

  def holding_orders
    orders.where(state: '已起息')
  end
end
