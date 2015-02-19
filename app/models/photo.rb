class Photo < ActiveRecord::Base
  include Paperclip::Glue
  include Rails.application.routes.url_helpers

  belongs_to :community_article
  belongs_to :user

  #attr_accessible :photo

  has_attached_file :photo, 
    styles: { thumb: ["400x400"], medium: ["1024x768"] }, 
    default_url: "/gallery_images/:style/missing.png",
    url: "/gallery_images/:style/:basename.:extension",
    path: ":rails_root/public/gallery_images/:style/:basename.:extension"

  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/



  def to_photo_upload
    {
      "name" => read_attribute(:photo_file_name),
      "size" => read_attribute(:photo_file_size),
      "url" => photo.url(:original),
      "thumbnail_url" => photo.url(:thumb),
      "medium_url" => photo.url(:medium),
      "delete_url" => "/gallery/#{self.community_article_id}/photo?cid=#{self.id.to_s}",
      "delete_type" => "DELETE" 
    }
  end

end
