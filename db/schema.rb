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

ActiveRecord::Schema.define(version: 2019_04_15_141540) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "applications", force: :cascade do |t|
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "course_id"
    t.integer "status", default: 0
  end

uca  create_table "courses", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "intake"
    t.integer "status", default: 0
    t.integer "university_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "credit_amount_req", default: 0
    t.integer "english_grade_req", default: 0
    t.integer "math_grade_req", default: 0
    t.integer "science_amount_req", default: 0
  end

  create_table "papers", force: :cascade do |t|
    t.string "name"
    t.integer "exam", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "qualifications", force: :cascade do |t|
    t.integer "user_id"
    t.integer "course_id"
    t.integer "paper_id"
    t.integer "grade", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0
  end

  create_table "universities", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "address"
    t.string "phone"
    t.string "email"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.integer "role", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "university_id", default: 0
    t.string "first_name"
    t.string "last_name"
    t.integer "title", default: 0
    t.integer "gender", default: 0
    t.datetime "birthdate"
    t.text "address"
    t.string "phone"
    t.string "nric_passport"
    t.integer "nationality", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
