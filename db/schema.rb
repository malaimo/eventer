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

ActiveRecord::Schema.define(:version => 20120710174759) do

  create_table "countries", :force => true do |t|
    t.string   "name"
    t.string   "iso_code"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "events", :force => true do |t|
    t.string   "name"
    t.date     "date"
    t.string   "place"
    t.integer  "capacity"
    t.string   "city"
    t.integer  "country_id"
    t.integer  "trainer_id"
    t.string   "visibility_type",               :limit => 2
    t.decimal  "list_price",                                 :precision => 7, :scale => 2
    t.boolean  "list_price_plus_tax"
    t.integer  "list_price_2_pax_discount"
    t.integer  "list_price_3plus_pax_discount"
    t.decimal  "seb_price",                                  :precision => 7, :scale => 2
    t.date     "seb_end_date"
    t.decimal  "eb_price",                                   :precision => 7, :scale => 2
    t.date     "eb_end_date"
    t.text     "description"
    t.text     "recipients"
    t.text     "program"
    t.boolean  "draft"
    t.boolean  "cancelled"
    t.datetime "created_at",                                                               :null => false
    t.datetime "updated_at",                                                               :null => false
  end

  add_index "events", ["country_id"], :name => "index_events_on_country_id"
  add_index "events", ["trainer_id"], :name => "index_events_on_trainer_id"

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  create_table "trainers", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.text     "bio"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
