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

ActiveRecord::Schema.define(version: 20150627182358) do

  create_table "games", force: :cascade do |t|
    t.string   "name"
    t.integer  "secs_left"
    t.integer  "num_users"
    t.boolean  "open"
    t.integer  "status_cd"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

<<<<<<< Updated upstream
=======
  create_table "messages", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "game_id"
    t.string   "the_text"
    t.datetime "the_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "messages", ["game_id"], name: "index_messages_on_game_id"
  add_index "messages", ["user_id"], name: "index_messages_on_user_id"

>>>>>>> Stashed changes
  create_table "moves", force: :cascade do |t|
    t.integer  "users_id"
    t.integer  "number_of_moves"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "player_id"
  end

<<<<<<< Updated upstream
  add_index "moves", ["player_id"], name: "index_moves_on_player_id", using: :btree
  add_index "moves", ["users_id"], name: "index_moves_on_users_id", using: :btree
=======
  add_index "moves", ["player_id"], name: "index_moves_on_player_id"
  add_index "moves", ["users_id"], name: "index_moves_on_users_id"
>>>>>>> Stashed changes

  create_table "players", force: :cascade do |t|
    t.string   "name"
    t.string   "comment"
    t.integer  "user_id"
    t.integer  "game_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "players", ["game_id"], name: "index_players_on_game_id"
  add_index "players", ["user_id"], name: "index_players_on_user_id"

  create_table "users", force: :cascade do |t|
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "name"
    t.string   "password"
    t.string   "password_confirmation"
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
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

<<<<<<< Updated upstream
  add_foreign_key "moves", "players"
  add_foreign_key "players", "games"
  add_foreign_key "players", "users"
=======
>>>>>>> Stashed changes
end
