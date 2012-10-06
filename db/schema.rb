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

ActiveRecord::Schema.define(:version => 20121006164852) do

  create_table "brands", :force => true do |t|
    t.string   "name"
    t.boolean  "reviewed",    :default => false, :null => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.integer  "posts_count", :default => 0
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.string   "param"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "category_hashtag_values", :force => true do |t|
    t.integer  "category_id"
    t.integer  "hashtag_value_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "flag_types", :force => true do |t|
    t.string   "name",        :limit => 60, :null => false
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.string   "domain_name"
  end

  create_table "hashtag_flags", :force => true do |t|
    t.integer  "flag_type_id",                :null => false
    t.integer  "hashtag_id",                  :null => false
    t.integer  "user_id",                     :null => false
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.integer  "status",       :default => 1, :null => false
  end

  add_index "hashtag_flags", ["flag_type_id"], :name => "fk_hashtag_flags_flag_types"
  add_index "hashtag_flags", ["hashtag_id"], :name => "fk_hashtag_flags_hashtags"
  add_index "hashtag_flags", ["user_id"], :name => "fk_hashtag_flags_users"

  create_table "hashtag_values", :force => true do |t|
    t.string   "value",          :limit => 60,                :null => false
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
    t.integer  "hashtags_count",               :default => 0
  end

  create_table "hashtagbrands", :force => true do |t|
    t.integer  "brand_id"
    t.integer  "hashtag_value_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "hashtagbrands", ["brand_id"], :name => "index_hashtagbrands_on_brand_id"
  add_index "hashtagbrands", ["hashtag_value_id"], :name => "index_hashtagbrands_on_hashtag_value_id"

  create_table "hashtags", :force => true do |t|
    t.integer  "hashtag_value_id",                :null => false
    t.integer  "post_id",                         :null => false
    t.integer  "user_id",                         :null => false
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.integer  "status",           :default => 1, :null => false
  end

  add_index "hashtags", ["hashtag_value_id"], :name => "fk_hashtags_hashtag_values"
  add_index "hashtags", ["post_id"], :name => "fk_hashtags_posts"
  add_index "hashtags", ["user_id"], :name => "fk_hashtags_users"

  create_table "images", :force => true do |t|
    t.string   "uri"
    t.binary   "image"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "item_visits", :force => true do |t|
    t.integer  "item_id",    :null => false
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "item_visits", ["item_id"], :name => "fk_item_visits_items"
  add_index "item_visits", ["user_id"], :name => "fk_item_visits_users"

  create_table "items", :force => true do |t|
    t.integer  "user_id",                                  :null => false
    t.integer  "post_id",                                  :null => false
    t.integer  "parent_id"
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
    t.integer  "status",                    :default => 1, :null => false
    t.integer  "views",                     :default => 0, :null => false
    t.integer  "visits",                    :default => 0, :null => false
    t.integer  "relifts",                   :default => 0, :null => false
    t.string   "comment",    :limit => 100
  end

  add_index "items", ["parent_id"], :name => "fk_items_parents"
  add_index "items", ["post_id"], :name => "fk_items_posts"
  add_index "items", ["user_id"], :name => "fk_items_users"

  create_table "post_flags", :force => true do |t|
    t.integer  "flag_type_id",                :null => false
    t.integer  "post_id",                     :null => false
    t.integer  "user_id",                     :null => false
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.integer  "status",       :default => 1, :null => false
  end

  add_index "post_flags", ["flag_type_id"], :name => "fk_post_flags_flag_types"
  add_index "post_flags", ["post_id"], :name => "fk_post_flags_posts"
  add_index "post_flags", ["user_id"], :name => "fk_post_flags_users"

  create_table "posts", :force => true do |t|
    t.string   "name",               :limit => 110,                                                   :null => false
    t.text     "description"
    t.string   "retailer",                                                                            :null => false
    t.string   "url",                :limit => 2083,                                                  :null => false
    t.decimal  "price",                              :precision => 10, :scale => 2
    t.boolean  "hashtags_allowed",                                                  :default => true, :null => false
    t.string   "comment",            :limit => 100
    t.integer  "user_id",                                                                             :null => false
    t.datetime "created_at",                                                                          :null => false
    t.datetime "updated_at",                                                                          :null => false
    t.integer  "status",                                                            :default => 1,    :null => false
    t.integer  "views",                                                             :default => 0,    :null => false
    t.integer  "visits",                                                            :default => 0,    :null => false
    t.integer  "relifts",                                                           :default => 0,    :null => false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer  "brand_id"
  end

  add_index "posts", ["user_id"], :name => "fk_posts_users"

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  create_table "set_asides", :force => true do |t|
    t.integer  "user_id",                   :null => false
    t.integer  "item_id",                   :null => false
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.integer  "status",     :default => 1, :null => false
  end

  add_index "set_asides", ["item_id"], :name => "fk_set_asides_items"
  add_index "set_asides", ["user_id"], :name => "fk_set_asides_users"

  create_table "string_blacklists", :primary_key => "name", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "subscriptions", :force => true do |t|
    t.integer  "user_id",                    :null => false
    t.integer  "follower_id",                :null => false
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.integer  "status",      :default => 1, :null => false
  end

  add_index "subscriptions", ["follower_id"], :name => "fk_subscriptions_followers"
  add_index "subscriptions", ["user_id"], :name => "fk_subscriptions_users"

  create_table "user_item_views", :force => true do |t|
    t.integer  "user_id"
    t.integer  "item_id"
    t.datetime "created_at"
  end

  add_index "user_item_views", ["item_id"], :name => "index_user_item_views_on_item_id"
  add_index "user_item_views", ["user_id", "item_id"], :name => "index_user_item_views_on_user_id_and_item_id"
  add_index "user_item_views", ["user_id"], :name => "index_user_item_views_on_user_id"

  create_table "username_blacklists", :primary_key => "name", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "",    :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                               :null => false
    t.datetime "updated_at",                                               :null => false
    t.string   "full_name"
    t.string   "username",               :limit => 40,                     :null => false
    t.boolean  "sex"
    t.string   "biography",              :limit => 110
    t.text     "url"
    t.string   "hometown",               :limit => 110
    t.date     "birthdate"
    t.boolean  "private",                               :default => false, :null => false
    t.integer  "status",                                :default => 1,     :null => false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "vanity_url"
    t.string   "country"
    t.string   "zipcode"
    t.string   "missing"
    t.boolean  "notify_new_follower"
    t.boolean  "notify_relift"
    t.string   "notify_missing"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "authentication_token"
    t.integer  "count_of_followers",                    :default => 0
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "count_of_posts",                        :default => 0
    t.integer  "count_of_hashtags",                     :default => 0
    t.string   "facebook_token"
    t.string   "twitter_token"
    t.string   "twitter_secret"
    t.string   "signup_state"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["signup_state"], :name => "index_users_on_signup_state"

  create_table "xpaths", :force => true do |t|
    t.string   "retailer",   :null => false
    t.string   "brand"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "name"
    t.string   "price"
  end

end
