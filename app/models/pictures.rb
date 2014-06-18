class Pictures < ActiveRecord::Base
	attr_accessible :product_item_id, :image

  belongs_to :product_item

  has_attached_file :image,
    :path => ":rails_root/public/images/:id/:filename",
    :url  => "/images/:id/:filename"

  do_not_validate_attachment_file_type :image
end
