class Picture < ActiveRecord::Base
	attr_accessible :product_item_id, :image

  belongs_to :product_item

  #~ has_attached_file :image,
    #~ :path => ":rails_root/public/images/:id/:filename",
    #~ :url  => "/images/:id/:filename"
		
	has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"

  validates_attachment_content_type :image, :content_type => %w(image/jpeg image/jpg)
end
