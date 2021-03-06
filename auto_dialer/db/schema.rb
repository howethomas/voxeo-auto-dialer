# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20080807125605) do

  create_table "Apps", :force => true do |t|
    t.string   "name"
    t.string   "wait_wav"
    t.string   "app_human"
    t.string   "app_machine"
    t.integer  "account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "calls_per_minute"
    t.string   "app_beep"
    t.string   "start_url"
    t.string   "fields"
  end

  create_table "accounts", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contacts", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "phone"
    t.string   "cell"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "post_code"
    t.string   "time_zone"
    t.string   "account_id"
    t.string   "tags"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "custom0"
    t.string   "custom1"
    t.string   "custom2"
    t.string   "custom3"
    t.string   "custom4"
  end

  create_table "contacts_groups", :id => false, :force => true do |t|
    t.integer "contact_id", :null => false
    t.integer "group_id",   :null => false
  end

  create_table "contacts_schedules", :id => false, :force => true do |t|
    t.integer "contact_id",  :null => false
    t.integer "schedule_id", :null => false
  end

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.boolean  "enabled"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups_schedules", :id => false, :force => true do |t|
    t.integer "group_id",    :null => false
    t.integer "schedule_id", :null => false
  end

  create_table "histories", :force => true do |t|
    t.integer  "schedule_id"
    t.integer  "contact_id"
    t.string   "result"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "models", :force => true do |t|
    t.string   "test"
    t.integer  "test2"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "options", :force => true do |t|
    t.string   "version"
    t.boolean  "mock"
    t.integer  "debug_level"
    t.string   "admin_name"
    t.string   "admin_email"
    t.boolean  "daily_summary"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "admin_phone"
    t.string   "support_url"
  end

  create_table "runners", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "schedules", :force => true do |t|
    t.datetime "start"
    t.integer  "account_id"
    t.integer  "app_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "tags"
    t.string   "state"
  end

  create_table "tasks", :force => true do |t|
    t.integer  "schedule_id"
    t.integer  "app_id"
    t.datetime "start"
    t.boolean  "started"
    t.boolean  "completed"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "contact_id"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "email"
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.integer  "account_id",                              :default => 0
  end

  create_table "utilities", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
