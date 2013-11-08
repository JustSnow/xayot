class CreatePostsTable < ActiveRecord::Migration
  def change
  	create_table :posts do |t|
  		t.integer :category_id
  		t.text :intro
  		t.text :full
  	end

  	add_index :posts, :category_id
  end
end
