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

ActiveRecord::Schema.define(:version => 20120614120315) do

  create_table "ride_requests", :force => true do |t|
    t.integer  "ride_id",       :null => false
    t.integer  "user_id",       :null => false
    t.date     "start_date"
    t.time     "start_time"
    t.date     "end_date"
    t.time     "end_time"
    t.string   "start_address"
    t.string   "end_address"
    t.float    "start_lat"
    t.float    "start_long"
    t.float    "end_lat"
    t.float    "end_long"
    t.string   "request_code"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "ride_requests", ["request_code"], :name => "index_ride_requests_on_request_code"

  create_table "rides", :force => true do |t|
    t.integer  "user_id",            :null => false
    t.string   "start_address",      :null => false
    t.string   "end_address",        :null => false
    t.float    "start_lat"
    t.float    "start_long"
    t.float    "end_lat"
    t.float    "end_long"
    t.date     "start_date",         :null => false
    t.time     "start_time",         :null => false
    t.date     "end_date",           :null => false
    t.time     "end_time",           :null => false
    t.integer  "distance_in_meters"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "rides", ["user_id"], :name => "index_rides_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email",                              :null => false
    t.string   "password_digest",                    :null => false
    t.string   "first_name"
    t.string   "last_name"
    t.date     "date_of_birth"
    t.string   "location"
    t.string   "mobile_number"
    t.string   "remember_token"
    t.boolean  "admin",           :default => false
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "image_url"
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
