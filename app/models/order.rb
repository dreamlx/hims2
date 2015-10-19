class Order < ActiveRecord::Base
  ORDER_STATES = ["已经预约，等待完成报单", "info_short", "money_short", "已经完成报单，等待起息", "已起息，但合同文本基金管理人未收讫", "completed"]
  DELIVER_STATES = ["未快递", "已快递"]
  validates :investable, presence: true
  validates :product_id, presence: true
  validates :amount, numericality: true
  validates :amount, numericality: {greater_than_or_equal_to: 0.01}, on: :create
  validates :state, inclusion: ORDER_STATES
  validates :deliver,inclusion: DELIVER_STATES
  belongs_to :investable, polymorphic: true
  belongs_to :product
  belongs_to :user
  has_many :money_receipts, dependent: :destroy
  has_many :infos, dependent: :destroy

  mount_uploader :other, ImageUploader

  after_create :after_create

  state_machine :state, :initial => :'已经预约，等待完成报单' do
    event :get_info do
      transition :'已经预约，等待完成报单' => :money_short, :info_short => :'已经完成报单，等待起息'
    end
    event :get_money do
      transition :'已经预约，等待完成报单' => :info_short, :money_short => :'已经完成报单，等待起息'
    end
    event :value do
      transition :'已经完成报单，等待起息' => :'已起息，但合同文本基金管理人未收讫'
    end
    event :finsh do
      transition :'已起息，但合同文本基金管理人未收讫' => :completed
    end
  end

  def after_create
    update(user_id: self.investable.user_id, booking_date: self.created_at)
    if investable_type == "Individual"
      product.individual_fields.each do |field|
        infos.create(
          category: field.category,
          field_name: field.field_name,
          field_type: field.field_type)
      end
    elsif investable_type == "Institution"
      product.institution_fields.each do |field|
        infos.create(
          category: field.category,
          field_name: field.field_name,
          field_type: field.field_type)
      end
    end
  end
end
