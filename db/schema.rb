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

ActiveRecord::Schema.define(:version => 20130729190751) do

  create_table "activities", :force => true do |t|
    t.integer  "log_entry_id"
    t.integer  "activity_category_id"
    t.float    "hours"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  add_index "activities", ["activity_category_id"], :name => "index_activities_on_activity_category_id"
  add_index "activities", ["log_entry_id"], :name => "index_activities_on_log_entry_id"

  create_table "activity_categories", :force => true do |t|
    t.string   "name"
    t.string   "code"
    t.decimal  "weight",     :default => 1.0
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  create_table "activity_logs", :force => true do |t|
    t.date     "start_date"
    t.integer  "user_id"
    t.integer  "survey_id"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.boolean  "unconfirmed", :default => false
  end

  add_index "activity_logs", ["survey_id"], :name => "index_activity_logs_on_survey_id"
  add_index "activity_logs", ["user_id"], :name => "index_activity_logs_on_user_id"

  create_table "counties", :force => true do |t|
    t.string "name", :null => false
  end

  add_index "counties", ["name"], :name => "index_counties_on_name", :unique => true

  create_table "favorite_activities", :force => true do |t|
    t.integer "user_id"
    t.integer "county_id"
    t.integer "job_classification_id"
    t.integer "activity_category_id",  :null => false
  end

  add_index "favorite_activities", ["county_id"], :name => "index_favorite_activities_on_county_id"
  add_index "favorite_activities", ["job_classification_id"], :name => "index_favorite_activities_on_job_classification_id"
  add_index "favorite_activities", ["user_id"], :name => "index_favorite_activities_on_user_id"

  create_table "job_classifications", :force => true do |t|
    t.string "name"
  end

  create_table "log_entries", :force => true do |t|
    t.date     "date"
    t.integer  "activity_log_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.float    "hours"
  end

  add_index "log_entries", ["activity_log_id", "date"], :name => "index_log_entries_on_activity_log_id_and_date", :unique => true
  add_index "log_entries", ["activity_log_id"], :name => "index_log_entries_on_activity_log_id"

  create_table "surveys", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "county_id"
    t.date     "start_date"
  end

  add_index "surveys", ["county_id"], :name => "index_surveys_on_county_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.boolean  "admin",                  :default => false
    t.integer  "county_id"
    t.integer  "job_classification_id"
    t.string   "authentication_token"
  end

  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token", :unique => true
  add_index "users", ["county_id"], :name => "index_users_on_county_id"
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["job_classification_id"], :name => "index_users_on_job_classification_id"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
