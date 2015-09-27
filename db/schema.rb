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

ActiveRecord::Schema.define(version: 20150927070150) do

  create_table "cell_codes", force: :cascade do |t|
    t.string   "cell",       limit: 255
    t.string   "code",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "funds", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.string   "desc",         limit: 255
    t.string   "title1",       limit: 255
    t.string   "content1",     limit: 255
    t.string   "title2",       limit: 255
    t.string   "content2",     limit: 255
    t.string   "title3",       limit: 255
    t.string   "content3",     limit: 255
    t.integer  "progress_bar", limit: 4,   default: 0
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  create_table "individuals", force: :cascade do |t|
    t.integer  "user_id",     limit: 4
    t.string   "name",        limit: 255
    t.string   "cell",        limit: 255
    t.string   "remark_name", limit: 255
    t.string   "id_type",     limit: 255
    t.string   "id_no",       limit: 255
    t.string   "id_front",    limit: 255
    t.string   "id_back",     limit: 255
    t.string   "remark",      limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "individuals", ["user_id"], name: "index_individuals_on_user_id", using: :btree

  create_table "institutions", force: :cascade do |t|
    t.integer  "user_id",           limit: 4
    t.string   "name",              limit: 255
    t.string   "cell",              limit: 255
    t.string   "remark_name",       limit: 255
    t.string   "organ_reg",         limit: 255
    t.string   "business_licenses", limit: 255
    t.string   "remark",            limit: 255
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "institutions", ["user_id"], name: "index_institutions_on_user_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.integer  "investable_id",   limit: 4
    t.string   "investable_type", limit: 255
    t.integer  "product_id",      limit: 4
    t.integer  "user_id",         limit: 4
    t.decimal  "amount",                      precision: 12, scale: 2, default: 0.0
    t.date     "due_date"
    t.string   "mail_address",    limit: 255
    t.string   "other",           limit: 255
    t.string   "remark",          limit: 255
    t.string   "state",           limit: 255
    t.datetime "booking_date"
    t.datetime "created_at",                                                         null: false
    t.datetime "updated_at",                                                         null: false
  end

  add_index "orders", ["investable_type", "investable_id"], name: "index_orders_on_investable_type_and_investable_id", using: :btree
  add_index "orders", ["product_id"], name: "index_orders_on_product_id", using: :btree
  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "products", force: :cascade do |t|
    t.integer  "fund_id",           limit: 4
    t.string   "name",              limit: 255
    t.string   "desc",              limit: 255
    t.string   "title1",            limit: 255
    t.string   "content1",          limit: 255
    t.string   "title2",            limit: 255
    t.string   "content2",          limit: 255
    t.string   "title3",            limit: 255
    t.string   "content3",          limit: 255
    t.integer  "progress_bar",      limit: 4,   default: 0
    t.string   "abbr",              limit: 255
    t.string   "currency",          limit: 255
    t.string   "amount",            limit: 255
    t.string   "period",            limit: 255
    t.string   "paid",              limit: 255
    t.string   "sales_period",      limit: 255
    t.string   "block_period",      limit: 255
    t.string   "redeem",            limit: 255
    t.string   "entity",            limit: 255
    t.string   "adviser",           limit: 255
    t.string   "trustee",           limit: 255
    t.string   "reg_organ",         limit: 255
    t.string   "website",           limit: 255
    t.string   "agency",            limit: 255
    t.string   "regulatory_filing", limit: 255
    t.string   "legal_consultant",  limit: 255
    t.string   "audit",             limit: 255
    t.string   "starting_point",    limit: 255
    t.string   "account",           limit: 255
    t.string   "progress",          limit: 255
    t.string   "direction",         limit: 255
    t.string   "risk_control",      limit: 255
    t.string   "instruction",       limit: 255
    t.string   "agreement",         limit: 255
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

  add_index "products", ["fund_id"], name: "index_products_on_fund_id", using: :btree

  create_table "rois", force: :cascade do |t|
    t.integer  "product_id", limit: 4
    t.string   "range",      limit: 255
    t.string   "profit",     limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "rois", ["product_id"], name: "index_rois_on_product_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "open_id",    limit: 255
    t.string   "cell",       limit: 255
    t.string   "name",       limit: 255
    t.string   "email",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "id_type",    limit: 255
    t.string   "nickname",   limit: 255
    t.string   "gender",     limit: 255
    t.string   "address",    limit: 255
    t.string   "card_type",  limit: 255
    t.string   "card_no",    limit: 255
    t.string   "card_front", limit: 255
    t.string   "card_back",  limit: 255
    t.string   "remark",     limit: 255
  end

  add_foreign_key "individuals", "users"
  add_foreign_key "institutions", "users"
  add_foreign_key "orders", "products"
  add_foreign_key "orders", "users"
  add_foreign_key "products", "funds"
  add_foreign_key "rois", "products"
end
