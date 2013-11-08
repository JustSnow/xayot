class CreateTableMenus < ActiveRecord::Migration
  def change
  	create_table :menus do |t|
  		t.string :name
  		t.integer :parent_id
      t.integer :lft
      t.integer :rgt
      t.integer :depth
      t.boolean :published, default: true
      t.belongs_to :post
      t.belongs_to :category

  		t.timestamps
  	end

  	add_index :menus, :post_id
  	add_index :menus, :category_id
  end
end
