class User < ActiveRecord::Base
  validates :open_id, presence: true
  validates :cell, presence: true

  has_many :individuals
  has_many :institutions

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
