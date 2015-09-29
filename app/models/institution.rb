class Institution < ActiveRecord::Base
  validates :user_id, presence: true
  validates :name, presence: true
  validates :cell, presence: true

  belongs_to :user
  has_many :orders, as: :investable

  mount_uploader :business_licenses, ImageUploader

  def booking_orders
    orders.where('state=? OR state=? OR state=? OR state=?', '已经预约，等待完成报单', 'info_short', 'money_short', '已经完成报单，等待起息' )
  end

  def holding_orders
    orders.where('state=? OR state=?', '已起息，但合同文本基金管理人未收讫', 'completed')
  end
end
