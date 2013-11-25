class CreateTableCities < ActiveRecord::Migration
  def change
  	create_table :cities do |t|
  		t.string :country
  		t.string :name
  		t.string :street
  		t.string :home
  		t.integer :apartment

  		t.timestamps
  	end

  	add_column :users, :city_id, :integer
  	add_index :users, :city_id
  end
end
