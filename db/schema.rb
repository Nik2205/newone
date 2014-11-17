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

ActiveRecord::Schema.define(version: 0) do

  create_table "cities", primary_key: "city_id", force: true do |t|
    t.string "city_name", limit: 45, null: false
  end

  create_table "interests", primary_key: "interest_id", force: true do |t|
    t.string "interest_name", limit: 45, null: false
  end

  create_table "messages", primary_key: "message_id", force: true do |t|
    t.integer "sender_id",                      null: false
    t.integer "reciever_id",                    null: false
    t.string  "message",           limit: 4000
    t.date    "last_updated_date"
  end

  add_index "messages", ["reciever_id"], name: "FK_MESSAGES_USER_RECIEVER_idx", using: :btree
  add_index "messages", ["sender_id"], name: "FK_idx", using: :btree

  create_table "occupations", primary_key: "occupation_id", force: true do |t|
    t.string "occupation_name", limit: 45, null: false
  end

  create_table "pipe_blogs", primary_key: "pipe_blog_id", force: true do |t|
    t.integer "pipe_id"
    t.string  "pipe_content", limit: 8000
  end

  add_index "pipe_blogs", ["pipe_id"], name: "FK_PIPE_BLOGS_PIPES_idx", using: :btree

  create_table "pipe_comments", primary_key: "pipe_comment_id", force: true do |t|
    t.integer "pipe_id"
    t.integer "user_id"
    t.string  "comment",           limit: 2000
    t.date    "last_updated_date"
  end

  add_index "pipe_comments", ["pipe_id"], name: "FK_PIPE_COMMENTS_PIPES_idx", using: :btree
  add_index "pipe_comments", ["user_id"], name: "PIPE_COMMENTS_USERS_idx", using: :btree

  create_table "pipe_likes", primary_key: "pipe_like_id", force: true do |t|
    t.integer "pipe_id"
    t.integer "user_id"
    t.string  "last_updated_date", limit: 45
  end

  add_index "pipe_likes", ["pipe_id"], name: "FK_PIPE_LIKE_PIPES_idx", using: :btree
  add_index "pipe_likes", ["user_id"], name: "FK_PIPE_LIKE_USERS_idx", using: :btree

  create_table "pipe_shares", primary_key: "pipe_share_id", force: true do |t|
    t.integer "pipe_id"
    t.integer "share_by"
    t.integer "share_to"
    t.date    "last_updated_date"
  end

  add_index "pipe_shares", ["pipe_id"], name: "FK_PIPE_SHARES_PIPES_idx", using: :btree
  add_index "pipe_shares", ["share_by"], name: "FK_PIPE_SHARES_USERS_SHARE_BY_idx", using: :btree
  add_index "pipe_shares", ["share_to"], name: "FK_PIPE_SHARES_USER_SHARETO_idx", using: :btree

  create_table "pipe_statuses", primary_key: "pipe_status_id", force: true do |t|
    t.integer "pipe_id"
    t.string  "pipe_status",      limit: 2000
    t.integer "pipe_status_type"
  end

  add_index "pipe_statuses", ["pipe_id"], name: "FK_PIPE_STATUSES_PIPES_idx", using: :btree

  create_table "pipe_tags", primary_key: "pipe_tags_id", force: true do |t|
    t.integer "pipe_id"
    t.string  "tag",      limit: 45
    t.integer "tag_type"
  end

  add_index "pipe_tags", ["pipe_id"], name: "FK_PIPE_TAGS_PIPES_idx", using: :btree

  create_table "pipe_videos", primary_key: "pipe_video_id", force: true do |t|
    t.integer "pipe_id"
    t.binary  "pipe_video"
  end

  add_index "pipe_videos", ["pipe_id"], name: "FK_PIPE_VIDEOS_PIPES_idx", using: :btree

  create_table "pipes", primary_key: "pipe_id", force: true do |t|
    t.string  "content",           limit: 4000
    t.integer "created_by",                     null: false
    t.date    "created_date"
    t.string  "updated_by",        limit: 45
    t.date    "last_updated_date"
  end

  add_index "pipes", ["created_by"], name: "FK_PIPES_USERS_idx", using: :btree

  create_table "user_interest_assocs", primary_key: "user_interest_id", force: true do |t|
    t.integer "user_id"
    t.integer "interest_id"
    t.date    "last_updated_date"
  end

  add_index "user_interest_assocs", ["interest_id"], name: "FK_USERS_INTERESTS_ASSOC_INTERESTS_idx", using: :btree
  add_index "user_interest_assocs", ["user_id"], name: "FK_USERS_INTERESTS_ASSOCS_USERS_idx", using: :btree

  create_table "user_types", primary_key: "user_type_id", force: true do |t|
    t.string "user_type", limit: 20, null: false
  end

  create_table "users", primary_key: "user_id", force: true do |t|
    t.string  "user_name",         limit: 20,                           null: false
    t.string  "first_name",        limit: 45
    t.string  "middle_name",       limit: 45
    t.string  "last_name",         limit: 45
    t.string  "email_id",          limit: 80,                           null: false
    t.string  "password",          limit: 150,                          null: false
    t.decimal "phone_no",                      precision: 11, scale: 0
    t.integer "occupation"
    t.integer "city"
    t.string  "address",           limit: 100
    t.integer "user_type_id",                                           null: false
    t.string  "created_by",        limit: 45
    t.string  "last_updated_by",   limit: 45
    t.date    "created_date"
    t.date    "last_updated_date"
  end

  add_index "users", ["city"], name: "FK_USERS_CITIES_idx", using: :btree
  add_index "users", ["occupation"], name: "FK_USERS_OCCUPATIONS_idx", using: :btree
  add_index "users", ["user_type_id"], name: "_idx", using: :btree

end
