class CreateTableGalleryPosts < ActiveRecord::Migration
  def change
    create_table :gallery_posts do |t|
      t.string   :image
      t.belongs_to :post
    end

    add_index :gallery_posts, :post_id
  end
end
