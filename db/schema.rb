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

ActiveRecord::Schema.define(version: 20170822102940) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "doses", force: :cascade do |t|
    t.string   "description"
    t.integer  "ingredient_id"
    t.integer  "recipe_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["ingredient_id"], name: "index_doses_on_ingredient_id", using: :btree
    t.index ["recipe_id"], name: "index_doses_on_recipe_id", using: :btree
  end

  create_table "ingredients", force: :cascade do |t|
    t.string   "name"
    t.integer  "january"
    t.integer  "february"
    t.integer  "march"
    t.integer  "april"
    t.integer  "may"
    t.integer  "june"
    t.integer  "july"
    t.integer  "august"
    t.integer  "september"
    t.integer  "october"
    t.integer  "november"
    t.integer  "december"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "past_recommendations", force: :cascade do |t|
    t.date     "date"
    t.integer  "recipe_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipe_id"], name: "index_past_recommendations_on_recipe_id", using: :btree
    t.index ["user_id"], name: "index_past_recommendations_on_user_id", using: :btree
  end

  create_table "recipes", force: :cascade do |t|
    t.string   "name"
    t.text     "instructions"
    t.integer  "cooking_time"
    t.integer  "preparation_time"
    t.string   "difficulty"
    t.string   "type"
    t.integer  "servings"
    t.integer  "seasonality"
    t.boolean  "vegan"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "photo"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "doses", "ingredients"
  add_foreign_key "doses", "recipes"
  add_foreign_key "past_recommendations", "recipes"
  add_foreign_key "past_recommendations", "users"
end
