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

ActiveRecord::Schema.define(version: 20170626000142) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "match_data", force: :cascade do |t|
    t.datetime "date"
    t.integer "result"
    t.integer "home_score"
    t.integer "away_score"
    t.string "home_team"
    t.string "away_team"
    t.float "match_streak"
    t.float "home_effectiveness"
    t.float "away_effectiveness"
    t.float "home_avg_goals"
    t.float "away_avg_goals"
    t.float "home_general_streak"
    t.float "away_general_streak"
    t.float "home_rank"
    t.float "away_rank"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "results", force: :cascade do |t|
    t.datetime "date"
    t.string "season"
    t.string "league"
    t.string "home_team"
    t.string "away_team"
    t.integer "home_score"
    t.integer "away_score"
    t.integer "difference"
    t.integer "result"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.string "zone"
    t.string "country"
    t.string "league"
    t.integer "rank"
    t.integer "rank_points"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
