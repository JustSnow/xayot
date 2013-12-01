class CreateTableActions < ActiveRecord::Migration
  def change
  	create_table :actions do |t|
  		t.string :name
  		t.string :alias
  		t.text :intro
  		t.text :full
  		t.text :seo
  		t.string :image
  		t.boolean :published, default: true
  		t.integer :price

  		t.integer :user_id
  		t.integer :city_id
  		t.integer :category_id

  		t.timestamps
  	end

  	add_index :actions, :user_id
  	add_index :actions, :city_id
  	add_index :actions, :category_id
  end
end
