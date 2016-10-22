class User < ActiveRecord::Base
  ID_TYPES = ["个人", "机构"]
  GENDER_TYPES = ["男", "女"]
  STATES = ["提交", "确认", "否决"]
  validates :open_id, presence: true
  validates :cell, presence: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :update }, allow_blank: true
  validates :id_type, inclusion: ID_TYPES, allow_blank: true
  validates :gender, inclusion: GENDER_TYPES, allow_blank: true
  validates :card_type, inclusion: Individual::ID_TYPES, allow_blank: true

  has_many :individuals, dependent: :destroy
  has_many :institutions, dependent: :destroy
  has_many :user_orders, class_name: "Order", dependent: :destroy
  has_many :orders, as: :investable,  dependent: :destroy
  mount_uploader :card_front, ImageUploader
  mount_uploader :card_back, ImageUploader

  scope :submitted, -> { where(state: '提交') }

  audited

  def User.send_code(cell, code)

    # the cell must exist and more than 11 digits
    return false unless cell && cell.to_s.length >= 11

    msg         = code.to_s
    @var        = {}
    @var["code"] = msg
    uri         = URI.parse("https://api.submail.cn/message/xsend.json")
    username    = Rails.application.secrets.sms_appid
    password    = Rails.application.secrets.sms_signature
    project     = Rails.application.secrets.sms_project
    res         = Net::HTTP.post_form(uri, appid: username, to: cell, project: project, signature: password, vars: @var.to_json)

    status      = JSON.parse(res.body)["status"]
    return ((status == "success") ? true : false)
  end
  # def User.send_code(cell, code)
  #   # the cell must exist and more than 11 digits
  #   return false unless cell && cell.to_s.length >= 11
  #   msg         = "微信公众号手机验证码：#{code}。#{APP_CONFIG['shortname']}咨询热线 #{APP_CONFIG['phone']}。"
  #   uri         = URI.parse("http://#{APP_CONFIG['ip']}/msg/HttpBatchSendSM")
  #   username    = Rails.application.secrets.sms_username
  #   password    = Rails.application.secrets.sms_password
  #   res         = Net::HTTP.post_form(uri, account: username, pswd: password, mobile: cell, msg: msg, needstatus: true)
  #   batch_code  = res.body.split[1]
  #   return (batch_code ? true : false)
  # end

  state_machine :state, :initial => :'提交' do
    event :confirm do
      transition [:'提交', :'否决'] => :'确认'
    end
    event :deny do
      transition [:'提交', :'确认'] => :'否决'
    end
    event :submit do
      transition [:'确认', :'否决'] => :'提交'
    end
  end
end
