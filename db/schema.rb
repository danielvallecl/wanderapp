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

ActiveRecord::Schema.define(version: 20180220150523) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "actives", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "event_id"
    t.boolean "status"
    t.string "obs"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_actives_on_event_id"
    t.index ["user_id"], name: "index_actives_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.string "obs"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.string "category"
    t.date "startdate"
    t.integer "duration"
    t.string "owner"
    t.string "city"
    t.string "country"
    t.string "address"
    t.string "obs"
    t.boolean "active"
    t.string "aux1"
    t.string "aux2"
    t.string "aux3"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "events_id"
    t.integer "user_id"
    t.float "latitude"
    t.float "longitude"
    t.string "formattedaddress"
    t.datetime "starttime"
    t.string "state"
    t.string "statecode"
    t.index ["events_id"], name: "index_events_on_events_id"
  end

  create_table "preferences", force: :cascade do |t|
    t.text "options"
    t.string "obs"
    t.string "aux1"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_preferences_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false
    t.string "firstname"
    t.string "lastname"
    t.string "country"
    t.string "city"
    t.float "latitude"
    t.float "longitude"
    t.string "ipaddress"
    t.integer "pref_id"
    t.string "state"
    t.string "statecode"
    t.bigint "preference_id"
    t.index ["preference_id"], name: "index_users_on_preference_id"
  end

  add_foreign_key "actives", "events"
  add_foreign_key "actives", "users"
  add_foreign_key "events", "events", column: "events_id"
  add_foreign_key "preferences", "users"
  add_foreign_key "users", "preferences"
end
