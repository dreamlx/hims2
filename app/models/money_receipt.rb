class MoneyReceipt < ActiveRecord::Base
  RECEIPT_STATES = ["未确认", "已确认", "已否决"]
  HEADERS = ["日期", "姓名", "金额", "手续费", "实际到帐", "起息金额", "资料认证", "理财师", "起息日", "渠道", "收益率"]
  validates :state, inclusion: RECEIPT_STATES
  validates :order_id, presence: true
  belongs_to :order

  mount_uploader :attach, ImageUploader

  state_machine :state, :initial => :'未确认' do
    event :confirm do
      transition [:'未确认', :'已否决'] => :'已确认'
    end
    event :deny do
      transition :'未确认' => :'已否决'
    end
  end
end
