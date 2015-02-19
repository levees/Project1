class Upload < ActiveRecord::Base
  include Paperclip::Glue
  include Rails.application.routes.url_helpers
  has_attached_file :attached, 
    styles: { thumb: ["100x100"], medium: ["800x600"] }, 
    #default_url: "/upload_images/:style_missing.png",
    url: "/upload_images/:style_:basename.:extension",
    path: ":rails_root/public/upload_images/:style_:basename.:extension"

  validates_attachment_content_type :attached, :content_type => /\Aimage\/.*\Z/

  def to_uploaded_image
    {
      "name" => read_attribute(:attached_file_name),
      "size" => read_attribute(:attached_file_size),
      "url" => attached.url(:original),
      "thumbnail_url" => attached.url(:thumb)
    }
  end

  def set_default_url_on_upload
    "/upload_images/:filename"
  end

end