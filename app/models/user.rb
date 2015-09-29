class User < ActiveRecord::Base
  ID_TYPES = ["个人", "机构"]
  GENDER_TYPES = ["男", "女"]
  validates :open_id, presence: true
  validates :cell, presence: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }, allow_blank: true
  validates :id_type, inclusion: ID_TYPES, allow_blank: true 
  validates :gender, inclusion: GENDER_TYPES, allow_blank: true
  validates :card_type, inclusion: Individual::ID_TYPES, allow_blank: true

  has_many :individuals
  has_many :institutions
  has_many :orders

  mount_uploader :card_front, ImageUploader
  mount_uploader :card_back, ImageUploader

  def User.send_code(cell, code)
    # the cell must exist and more than 11 digits
    return false unless cell && cell.to_s.length >= 11
    msg         = "#{code}"
    uri         = URI.parse("http://222.73.117.158/msg/HttpBatchSendSM")
    username    = Rails.application.secrets.sms_username
    password    = Rails.application.secrets.sms_password
    res         = Net::HTTP.post_form(uri, account: username, pswd: password, mobile: cell, msg: msg, needstatus: true)
    batch_code  = res.body.split[1]
    return (batch_code ? true : false)
  end  
end
