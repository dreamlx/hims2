class MoneyReceipt < ActiveRecord::Base
  RECEIPT_STATES = ["未确认", "已确认", "已否决"]
  validates :state, inclusion: RECEIPT_STATES
  validates :order_id, presence: true
  belongs_to :order

  mount_uploader :attach, FileUploader

  state_machine :state, :initial => :'未确认' do
    event :confirm do
      transition [:'未确认', :'已否决'] => :'已确认'
    end
    event :deny do
      transition :'未确认' => :'已否决'
    end
  end
end