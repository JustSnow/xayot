class CreateCategoriesTable < ActiveRecord::Migration
  def change
  	create_table :categories do |t|
  		t.integer :parent_id
      t.integer :lft
      t.integer :rgt
      t.integer :depth
  	end	
  end
end
