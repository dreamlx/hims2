class Individual < ActiveRecord::Base
  ID_TYPES = ["身份证","营业执照","护照","香港永久性居住身份证","台胞证","港澳同胞回乡证","驾照"]
  HEADERS = ["id", "user_id", "name", "cell", "remark_name", "id_type", "id_no", "id_front", "id_back", "remark", "created_at", "updated_at", "state"]
  validates :user_id, presence: true
  validates :name, presence: true
  validates :id_type, inclusion: ID_TYPES, allow_blank: true

  belongs_to :user
  has_many :orders, as: :investable, dependent: :destroy

  mount_uploader :id_front, ImageUploader
  mount_uploader :id_back, ImageUploader

  scope :submitted, -> { where(state: '提交') }

  audited

  def booking_orders
    orders.where('state=? OR state=?', '已预约', '已报单' )
  end

  def holding_orders
    orders.where(state: '已起息')
  end

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