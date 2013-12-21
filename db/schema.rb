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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20131220014726) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: true do |t|
    t.string   "encrypted_private_key"
    t.string   "public_key"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "addresses", ["encrypted_private_key"], name: "index_addresses_on_encrypted_private_key", using: :btree
  add_index "addresses", ["public_key"], name: "index_addresses_on_public_key", using: :btree

  create_table "transactions", force: true do |t|
    t.integer  "satoshis"
    t.string   "tx_hash"
    t.integer  "tweet_tip_id"
    t.integer  "address_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tweet_tips", force: true do |t|
    t.string   "content"
    t.string   "screen_name"
    t.string   "api_tweet_id_str"
    t.integer  "recipient_id"
    t.integer  "sender_id"
    t.integer  "transaction_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tweet_tips", ["content"], name: "index_tweet_tips_on_content", using: :btree

  create_table "users", force: true do |t|
    t.string   "screen_name"
    t.boolean  "authenticated", default: false
    t.string   "uid"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["screen_name"], name: "index_users_on_screen_name", using: :btree
  add_index "users", ["slug"], name: "index_users_on_slug", using: :btree
  add_index "users", ["uid"], name: "index_users_on_uid", using: :btree

end
