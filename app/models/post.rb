class Post < ActiveRecord::Base
	  # mount_uploader :pict, AvatarUploader
	belongs_to :user
	mount_uploader :pict, AvatarUploader
	has_many :post_attachments
   accepts_nested_attributes_for :post_attachments
end
