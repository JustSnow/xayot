class CreateContentsTable < ActiveRecord::Migration
  def change
  	create_table :contents do |t|
  		t.integer :node_id
  		t.string :node_type
  		t.string :name
  		t.string :alias
  		t.text :seo
  		t.integer :user_id
  		t.boolean :published, default: true
      t.string :image

  		t.timestamps
  	end

    add_index :contents, :node_id
    add_index :contents, :node_type
  	add_index :contents, :user_id
  end
end
