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

ActiveRecord::Schema.define(version: 20141027000001) do

  create_table "communities", force: true do |t|
    t.string   "community_name", limit: 45, default: "", null: false
    t.string   "community_path", limit: 45, default: "", null: false
    t.datetime "created_at"
  end

  create_table "community_article_comments", force: true do |t|
    t.integer  "user_id",                                     null: false
    t.integer  "community_article_id",            default: 0, null: false
    t.text     "comment"
    t.string   "ip_address",           limit: 15
    t.integer  "ip_number",            limit: 8,  default: 0
    t.integer  "state",                limit: 1,  default: 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "community_article_comments", ["community_article_id"], name: "nn_community_article_comments_article_id", using: :btree
  add_index "community_article_comments", ["user_id"], name: "fk_community_article_comments_users_id", using: :btree

  create_table "community_articles", force: true do |t|
    t.integer  "user_id",                              null: false
    t.integer  "community_id",            default: 0,  null: false
    t.string   "title",                   default: "", null: false
    t.text     "body"
    t.string   "ip_address",   limit: 15
    t.integer  "ip_number",    limit: 8,  default: 0
    t.integer  "state",        limit: 1,  default: 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "community_articles", ["community_id"], name: "nn_community_articles_community_id", using: :btree
  add_index "community_articles", ["user_id"], name: "fk_community_articles_users_id", using: :btree

  create_table "photos", force: true do |t|
    t.integer  "user_id",                           null: false
    t.integer  "community_article_id",              null: false
    t.string   "photo_file_name",      default: "", null: false
    t.string   "photo_content_type",   default: "", null: false
    t.integer  "photo_file_size",      default: 0,  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "photos", ["community_article_id"], name: "fk_photos_community_id", using: :btree
  add_index "photos", ["user_id"], name: "fk_photos_user_id", using: :btree

  create_table "uploads", force: true do |t|
    t.string   "attached_file_name",    default: "", null: false
    t.string   "attached_content_type", default: "", null: false
    t.integer  "attached_file_size",    default: 0,  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "zipcode"
    t.integer  "userlevel",              default: 1
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
