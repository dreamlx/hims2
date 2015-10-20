class Order < ActiveRecord::Base
  ORDER_STATES = ["已预约", "已报单", "已起息", "已关闭"]
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

  state_machine :state, :initial => :'已预约' do
    event :fill do
      transition :'已预约' => :'已报单'
    end
    event :value do
      transition :'已报单' => :'已起息'
    end
    event :close do
      transition :'已起息' => :'已关闭'
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
