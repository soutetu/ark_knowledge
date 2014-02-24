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

ActiveRecord::Schema.define(version: 20131028140558) do

  create_table "affiliations", force: true do |t|
    t.integer  "user_id",    null: false
    t.integer  "group_id",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "answer_users", force: true do |t|
    t.integer  "user_id",        null: false
    t.integer  "qa_category_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "answers", force: true do |t|
    t.text     "message",     null: false
    t.integer  "question_id", null: false
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "attachments", force: true do |t|
    t.string   "orig_name",        limit: 100, null: false
    t.string   "content_type",     limit: 50,  null: false
    t.integer  "file_size"
    t.integer  "file_category_id",             null: false
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "board_categories", force: true do |t|
    t.string   "name",        limit: 30,  null: false
    t.string   "description", limit: 100
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "boards", force: true do |t|
    t.string   "title",             limit: 40, null: false
    t.text     "body",                         null: false
    t.integer  "user_id"
    t.integer  "board_category_id",            null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", force: true do |t|
    t.text     "message",    null: false
    t.integer  "board_id",   null: false
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "file_categories", force: true do |t|
    t.string   "name",        limit: 30,  null: false
    t.string   "description", limit: 100
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", force: true do |t|
    t.string   "name",        limit: 30,  null: false
    t.string   "description", limit: 100
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "qa_categories", force: true do |t|
    t.string   "name",        limit: 30,  null: false
    t.string   "description", limit: 100
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions", force: true do |t|
    t.string   "title",           limit: 40, null: false
    t.text     "body",                       null: false
    t.string   "status",          limit: 20, null: false
    t.string   "replay_deadline", limit: 20, null: false
    t.integer  "user_id"
    t.integer  "qa_category_id",             null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "first_name",      limit: 20,              null: false
    t.string   "last_name",       limit: 20,              null: false
    t.string   "first_name_kana", limit: 40,              null: false
    t.string   "last_name_kana",  limit: 40,              null: false
    t.string   "email",           limit: 100,             null: false
    t.string   "salt",                                    null: false
    t.string   "password",                                null: false
    t.integer  "role",                        default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end
