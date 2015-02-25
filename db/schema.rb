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

ActiveRecord::Schema.define(version: 20150225162211) do

  create_table "admins", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "applicants", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "applications", force: true do |t|
    t.integer  "applicant_id"
    t.integer  "scholarship_id"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "assignments", force: true do |t|
    t.integer  "judge_id"
    t.integer  "scholarship_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "attachments", force: true do |t|
    t.string   "title"
    t.integer  "datum_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "data", force: true do |t|
    t.text     "value"
    t.integer  "field_id"
    t.integer  "application_id"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fields", force: true do |t|
    t.integer  "section_id"
    t.string   "title"
    t.text     "caption"
    t.string   "kind"
    t.text     "config"
    t.string   "completed_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invitations", force: true do |t|
    t.integer  "recommender_id"
    t.integer  "datum_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "complete"
  end

  create_table "judges", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "recommenders", force: true do |t|
    t.integer  "user_id"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reviews", force: true do |t|
    t.text     "notes"
    t.integer  "judge_id"
    t.integer  "application_id"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "scholarships", force: true do |t|
    t.string   "title"
    t.text     "caption"
    t.boolean  "global"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "requirements"
    t.string   "notes"
  end

  create_table "scores", force: true do |t|
    t.integer  "score"
    t.text     "notes"
    t.integer  "review_id"
    t.integer  "section_id"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sections", force: true do |t|
    t.string   "title"
    t.text     "caption"
    t.text     "review_comments"
    t.integer  "scholarship_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "name"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
