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

ActiveRecord::Schema.define(version: 20150131144236) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "auctions", force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.string   "auction_type"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "finished_at"
    t.decimal  "price",        precision: 10, scale: 2
    t.integer  "category_id"
    t.integer  "user_id"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  add_index "auctions", ["category_id"], name: "index_auctions_on_category_id", using: :btree
  add_index "auctions", ["user_id"], name: "index_auctions_on_user_id", using: :btree

  create_table "bids", force: :cascade do |t|
    t.decimal "price",      precision: 10, scale: 2
    t.integer "user_id"
    t.integer "auction_id"
  end

  add_index "bids", ["auction_id"], name: "index_bids_on_auction_id", using: :btree
  add_index "bids", ["user_id"], name: "index_bids_on_user_id", using: :btree

  create_table "categories", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.string  "comment_type"
    t.string  "content"
    t.integer "contract_id"
    t.integer "author_id"
    t.integer "user_for_id"
  end

  add_index "comments", ["author_id"], name: "index_comments_on_author_id", using: :btree
  add_index "comments", ["contract_id"], name: "index_comments_on_contract_id", using: :btree
  add_index "comments", ["user_for_id"], name: "index_comments_on_user_for_id", using: :btree

  create_table "contracts", force: :cascade do |t|
    t.integer "auction_id"
    t.integer "seller_id"
    t.integer "buyer_id"
    t.integer "seller_comment_id"
    t.integer "buyer_comment_id"
  end

  add_index "contracts", ["auction_id"], name: "index_s_on_auction_id", using: :btree
  add_index "contracts", ["buyer_comment_id"], name: "index_contracts_on_buyer_comment_id", using: :btree
  add_index "contracts", ["buyer_id"], name: "index_s_on_buyer_id", using: :btree
  add_index "contracts", ["seller_comment_id"], name: "index_contracts_on_seller_comment_id", using: :btree
  add_index "contracts", ["seller_id"], name: "index_s_on_seller_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "auctions", "categories"
  add_foreign_key "auctions", "users"
  add_foreign_key "bids", "auctions"
  add_foreign_key "bids", "users"
  add_foreign_key "comments", "contracts"
  add_foreign_key "comments", "users", column: "author_id"
  add_foreign_key "comments", "users", column: "user_for_id"
  add_foreign_key "contracts", "auctions"
  add_foreign_key "contracts", "comments", column: "buyer_comment_id"
  add_foreign_key "contracts", "comments", column: "seller_comment_id"
  add_foreign_key "contracts", "users", column: "buyer_id"
  add_foreign_key "contracts", "users", column: "seller_id"
end
