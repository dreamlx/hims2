class Product < ActiveRecord::Base
  validates :fund_id, presence: true
  validates :name, presence: true
  validates :desc, presence: true
  validates :progress_bar, numericality: {greater_than_or_equal_to: 0, less_than_or_equal_to: 100}
  belongs_to :fund
  has_many :rois, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :attaches, as: :attachable, dependent: :destroy
  has_many :info_fields, dependent: :destroy

  mount_uploader :instruction, FileUploader
  mount_uploader :agreement, FileUploader

  def individual_fields
    info_fields.where(category: "个人投资者")
  end

  def institution_fields
    info_fields.where(category: "机构投资者")
  end
end
