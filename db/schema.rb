# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20131201163152) do

  create_table "actions", :force => true do |t|
    t.string   "name"
    t.string   "alias"
    t.text     "intro"
    t.text     "full"
    t.text     "seo"
    t.string   "image"
    t.boolean  "published",   :default => true
    t.integer  "price"
    t.integer  "user_id"
    t.integer  "city_id"
    t.integer  "category_id"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  add_index "actions", ["category_id"], :name => "index_actions_on_category_id"
  add_index "actions", ["city_id"], :name => "index_actions_on_city_id"
  add_index "actions", ["user_id"], :name => "index_actions_on_user_id"

  create_table "categories", :force => true do |t|
    t.integer "parent_id"
    t.integer "lft"
    t.integer "rgt"
    t.integer "depth"
  end

  create_table "cities", :force => true do |t|
    t.string   "country"
    t.string   "name"
    t.string   "street"
    t.string   "home"
    t.integer  "apartment"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "ckeditor_assets", :force => true do |t|
    t.string   "data_file_name",                  :null => false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    :limit => 30
    t.string   "type",              :limit => 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], :name => "idx_ckeditor_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], :name => "idx_ckeditor_assetable_type"

  create_table "contents", :force => true do |t|
    t.integer  "node_id"
    t.string   "node_type"
    t.string   "name"
    t.string   "alias"
    t.text     "seo"
    t.integer  "user_id"
    t.boolean  "published",  :default => true
    t.string   "image"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  add_index "contents", ["node_id"], :name => "index_contents_on_node_id"
  add_index "contents", ["node_type"], :name => "index_contents_on_node_type"
  add_index "contents", ["user_id"], :name => "index_contents_on_user_id"

  create_table "gallery_posts", :force => true do |t|
    t.string  "image"
    t.integer "post_id"
  end

  add_index "gallery_posts", ["post_id"], :name => "index_gallery_posts_on_post_id"

  create_table "menus", :force => true do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth"
    t.boolean  "published",   :default => true
    t.integer  "post_id"
    t.integer  "category_id"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.integer  "user_id"
  end

  add_index "menus", ["category_id"], :name => "index_menus_on_category_id"
  add_index "menus", ["post_id"], :name => "index_menus_on_post_id"
  add_index "menus", ["user_id"], :name => "index_menus_on_user_id"

  create_table "posts", :force => true do |t|
    t.integer "category_id"
    t.text    "intro"
    t.text    "full"
    t.boolean "main"
    t.string  "video"
    t.integer "city_id"
    t.integer "parent_id"
    t.integer "lft"
    t.integer "rgt"
    t.integer "depth"
    t.string  "post_type",   :default => "post"
  end

  add_index "posts", ["category_id"], :name => "index_posts_on_category_id"
  add_index "posts", ["city_id"], :name => "index_posts_on_city_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",     :null => false
    t.string   "encrypted_password",     :default => "",     :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0,      :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "role",                   :default => "user"
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
    t.string   "first_name"
    t.string   "last_name"
    t.text     "description"
    t.text     "contacts"
    t.integer  "city_id"
  end

  add_index "users", ["city_id"], :name => "index_users_on_city_id"
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
