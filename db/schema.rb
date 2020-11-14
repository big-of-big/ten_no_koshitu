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

ActiveRecord::Schema.define(version: 2020_11_14_071128) do

  create_table "logs", force: :cascade do |t|
    t.string "name", null: false
    t.text "content", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_logs_on_name", unique: true
  end

  create_table "team_logs", force: :cascade do |t|
    t.string "name"
    t.integer "team_id"
    t.text "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name", "team_id"], name: "index_team_logs_on_name_and_team_id", unique: true
  end

  create_table "teams", force: :cascade do |t|
    t.string "name", null: false
    t.string "join_key", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "tenhou_accounts", force: :cascade do |t|
    t.string "name", null: false
    t.integer "team_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name", "team_id"], name: "index_tenhou_accounts_on_name_and_team_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "encrypted_password", default: "", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name", null: false
    t.integer "team_id"
    t.index ["name"], name: "index_users_on_name", unique: true
  end

end
