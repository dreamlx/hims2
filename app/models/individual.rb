class Individual < ActiveRecord::Base
  ID_TYPES = ["身份证","营业执照","护照","香港永久性居住身份证","台胞证","港澳同胞回乡证","驾照"]
  validates :user_id, presence: true
  validates :name, presence: true
  validates :cell, presence: true
  validates :id_type, inclusion: ID_TYPES, allow_blank: true

  belongs_to :user
  has_many :orders, as: :investable

  mount_uploader :id_front, ImageUploader
  mount_uploader :id_back, ImageUploader

  def booking_orders
    orders.where('state=? OR state=? OR state=? OR state=?', '已经预约，等待完成报单', 'info_short', 'money_short', '已经完成报单，等待起息' )
  end

  def holding_orders
    orders.where('state=? OR state=?', '已起息，但合同文本基金管理人未收讫', 'completed')
  end
end