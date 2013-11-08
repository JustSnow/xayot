class AddColumnForPosts < ActiveRecord::Migration
  def change
  	add_column :posts, :main, :boolean, { defaullt: false }
  end
end
