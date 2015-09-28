class Product < ActiveRecord::Base
  validates :fund_id, presence: true
  validates :name, presence: true
  validates :desc, presence: true
  validates :progress_bar, numericality: {greater_than_or_equal_to: 0, less_than_or_equal_to: 100}
  belongs_to :fund
  has_many :rois
  has_many :orders
  has_many :attaches, as: :attachable
  has_many :info_fields

  mount_uploader :instruction, FileUploader

  def individual_fields
    info_fields.where(category: "个人投资者")
  end

  def institution_fields
    info_fields.where(category: "机构投资者")
  end
end
