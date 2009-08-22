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

ActiveRecord::Schema.define(:version => 20090822141745) do

  create_table "entries", :force => true do |t|
    t.string   "title",      :null => false
    t.string   "link",       :null => false
    t.text     "content"
    t.string   "unique_key", :null => false
    t.string   "author"
    t.integer  "feed_id",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "feeds", :force => true do |t|
    t.string   "url",                :null => false
    t.string   "title"
    t.datetime "last_checked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "last_sent_entry_id"
  end

  create_table "subscriptions", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.integer  "feed_id",    :null => false
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                           :null => false
    t.string   "access_token",                    :null => false
    t.boolean  "active",       :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
