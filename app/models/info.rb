class Info < ActiveRecord::Base
  validates :field_type, inclusion: InfoField::FIELD_TYPES
  belongs_to :order

  mount_uploader :photo, FileUploader

  state_machine :state, :initial => :'未确认' do
    event :confirm do
      transition [:'未确认', :'已否决'] => :'已确认'
    end
    event :deny do
      transition :'未确认' => :'已否决'
    end
  end
end
