# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_12_05_201321) do

  create_table "draws", force: :cascade do |t|
    t.integer "roster_id"
    t.string "name_match"
    t.string "name_attempt"
    t.integer "play_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "draw_count"
    t.integer "draw_total"
  end

  create_table "plays", force: :cascade do |t|
    t.integer "user_id"
    t.string "correct_sum"
    t.string "incorrect_sum"
    t.string "result"
    t.integer "draws_count"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_play"
  end

  create_table "rosters", force: :cascade do |t|
    t.integer "badge_number"
    t.string "first_name"
    t.string "last_name"
    t.string "preferred_name"
    t.integer "shift"
    t.string "department"
    t.string "role"
    t.string "image"
    t.integer "draws_count"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "first_name"
    t.string "last_name"
    t.integer "badge_number"
    t.integer "plays_count"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "admin"
    t.integer "draw_correct"
  end

end
