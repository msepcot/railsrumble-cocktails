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

ActiveRecord::Schema.define(version: 20141019044755) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bars", force: true do |t|
    t.integer  "user_id"
    t.integer  "ingredient_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bars", ["ingredient_id"], name: "index_bars_on_ingredient_id", using: :btree
  add_index "bars", ["user_id"], name: "index_bars_on_user_id", using: :btree

  create_table "cocktails", force: true do |t|
    t.string   "name"
    t.string   "image"
    t.text     "instructions"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "drinkware_id"
    t.string   "served"
    t.string   "garnish"
    t.text     "ingredient_id_array"
  end

  add_index "cocktails", ["drinkware_id"], name: "index_cocktails_on_drinkware_id", using: :btree

  create_table "drinkwares", force: true do |t|
    t.string   "name"
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "favorites", force: true do |t|
    t.integer  "user_id"
    t.integer  "cocktail_id"
    t.integer  "order"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "favorites", ["cocktail_id"], name: "index_favorites_on_cocktail_id", using: :btree
  add_index "favorites", ["user_id"], name: "index_favorites_on_user_id", using: :btree

  create_table "groups", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ingredients", force: true do |t|
    t.string   "name"
    t.string   "image"
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ingredients", ["group_id"], name: "index_ingredients_on_group_id", using: :btree

  create_table "recipes", force: true do |t|
    t.integer  "cocktail_id"
    t.integer  "ingredient_id"
    t.string   "measurement"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "recipes", ["cocktail_id"], name: "index_recipes_on_cocktail_id", using: :btree
  add_index "recipes", ["ingredient_id"], name: "index_recipes_on_ingredient_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "guest"
  end

end
