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

ActiveRecord::Schema.define(:version => 20120630050829) do

  create_table "notifications", :force => true do |t|
    t.integer  "subject_id", :null => false
    t.string   "verb",       :null => false
    t.integer  "target_id"
    t.string   "type",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "object_id"
  end

  add_index "notifications", ["subject_id"], :name => "index_notifications_on_subject_id"
  add_index "notifications", ["target_id"], :name => "index_notifications_on_target_id"

  create_table "ride_requests", :force => true do |t|
    t.integer  "ride_id",                                     :null => false
    t.integer  "user_id",                                     :null => false
    t.datetime "start_time"
    t.datetime "end_time"
    t.string   "start_address"
    t.string   "end_address"
    t.float    "start_lat"
    t.float    "start_long"
    t.float    "end_lat"
    t.float    "end_long"
    t.string   "request_code"
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
    t.string   "status",               :default => "pending", :null => false
    t.date     "start_date"
    t.date     "end_date"
    t.float    "driver_score"
    t.datetime "driver_score_date"
    t.float    "passenger_score"
    t.datetime "passenger_score_date"
    t.string   "start_country"
    t.string   "end_country"
    t.string   "start_post_code"
    t.string   "end_post_code"
  end

  add_index "ride_requests", ["request_code"], :name => "index_ride_requests_on_request_code"

  create_table "rides", :force => true do |t|
    t.integer  "user_id",                                          :null => false
    t.string   "start_address",                                    :null => false
    t.string   "end_address",                                      :null => false
    t.float    "start_lat"
    t.float    "start_long"
    t.float    "end_lat"
    t.float    "end_long"
    t.datetime "start_time",                                       :null => false
    t.datetime "end_time",                                         :null => false
    t.integer  "distance_in_meters"
    t.datetime "created_at",                                       :null => false
    t.datetime "updated_at",                                       :null => false
    t.integer  "no_seats"
    t.date     "start_date"
    t.date     "end_date"
    t.decimal  "price",              :precision => 4, :scale => 2
    t.string   "start_country"
    t.string   "end_country"
    t.string   "start_post_code"
    t.string   "end_post_code"
  end

  add_index "rides", ["user_id"], :name => "index_rides_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email",                                                               :null => false
    t.string   "password_digest",                                                     :null => false
    t.string   "first_name"
    t.string   "last_name"
    t.date     "date_of_birth"
    t.string   "location"
    t.string   "mobile_number"
    t.string   "remember_token"
    t.boolean  "admin",                                            :default => false
    t.datetime "created_at",                                                          :null => false
    t.datetime "updated_at",                                                          :null => false
    t.string   "image_url"
    t.datetime "last_read"
    t.integer  "sign_in_count",                                    :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "sex"
    t.string   "locale"
    t.string   "timezone"
    t.string   "provider"
    t.string   "uid"
    t.decimal  "balance",            :precision => 4, :scale => 2, :default => 0.0
    t.integer  "total_votes",                                      :default => 0
    t.integer  "total_score",                                      :default => 0
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
