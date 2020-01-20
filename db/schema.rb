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

ActiveRecord::Schema.define(version: 2020_01_19_202140) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string "line_one"
    t.string "line_two"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.string "addressable_type"
    t.bigint "addressable_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["addressable_type", "addressable_id"], name: "index_addresses_on_addressable_type_and_addressable_id"
  end

  create_table "club_teams", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "fields", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "games", force: :cascade do |t|
    t.bigint "tournament_id", null: false
    t.string "team_one_type", null: false
    t.bigint "team_one_id", null: false
    t.string "team_two_type", null: false
    t.bigint "team_two_id", null: false
    t.bigint "field_id", null: false
    t.date "date"
    t.datetime "start_time"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["field_id"], name: "index_games_on_field_id"
    t.index ["team_one_type", "team_one_id"], name: "index_games_on_team_one_type_and_team_one_id"
    t.index ["team_two_type", "team_two_id"], name: "index_games_on_team_two_type_and_team_two_id"
    t.index ["tournament_id"], name: "index_games_on_tournament_id"
  end

  create_table "high_school_teams", force: :cascade do |t|
    t.string "school_name"
    t.string "team_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "players", force: :cascade do |t|
    t.string "first_name"
    t.string "middle_name"
    t.string "last_name"
    t.decimal "height"
    t.decimal "weight"
    t.date "birthday"
    t.bigint "high_school_team_id"
    t.bigint "club_team_id"
    t.decimal "gpa"
    t.string "class_year"
    t.string "intended_major"
    t.string "email"
    t.string "phone_number"
    t.text "notes"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["club_team_id"], name: "index_players_on_club_team_id"
    t.index ["high_school_team_id"], name: "index_players_on_high_school_team_id"
  end

  create_table "tournaments", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "games", "fields"
  add_foreign_key "games", "tournaments"
  add_foreign_key "players", "club_teams"
  add_foreign_key "players", "high_school_teams"
end
