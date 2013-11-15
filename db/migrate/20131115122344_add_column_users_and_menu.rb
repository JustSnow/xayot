class AddColumnUsersAndMenu < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :description, :text
    add_column :users, :contacts, :text

    add_column :menus, :user_id, :integer
    add_index  :menus, :user_id
  end
end
