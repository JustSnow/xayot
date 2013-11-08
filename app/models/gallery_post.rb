class GalleryPost < ActiveRecord::Base
  belongs_to :post

  attr_accessible :image, :post_id

  mount_uploader :image, GalleryUploader
  include Rails.application.routes.url_helpers

  def to_jq_upload(parent){
    'id' => self.id,
    "name" => read_attribute(:image),
    "size" => image.size,
    'url' => image.url,
    'thumbnail_url' => image.thumb.url,
    "delete_url" => admin_post_gallery_post_path(parent, self),
    "delete_type" => "DELETE"
  }
  end
end