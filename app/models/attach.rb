class Attach < ActiveRecord::Base
  belongs_to :attachable, polymorphic: true
  mount_uploader :attach, FileUploader
end
