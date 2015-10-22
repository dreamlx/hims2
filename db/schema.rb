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

ActiveRecord::Schema.define(version: 20151022113222) do

  create_table "admins", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.string   "password_digest", limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "attaches", force: :cascade do |t|
    t.string   "title",           limit: 255
    t.string   "attach",          limit: 255
    t.integer  "attachable_id",   limit: 4
    t.string   "attachable_type", limit: 255
    t.string   "category",        limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "attaches", ["attachable_type", "attachable_id"], name: "index_attaches_on_attachable_type_and_attachable_id", using: :btree

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
    t.string   "label",        limit: 255
    t.string   "currency",     limit: 255
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

  create_table "info_fields", force: :cascade do |t|
    t.integer  "product_id", limit: 4
    t.string   "category",   limit: 255
    t.string   "field_name", limit: 255
    t.string   "field_type", limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "info_fields", ["product_id"], name: "index_info_fields_on_product_id", using: :btree

  create_table "infos", force: :cascade do |t|
    t.integer  "order_id",   limit: 4
    t.string   "category",   limit: 255
    t.string   "field_name", limit: 255
    t.string   "field_type", limit: 255
    t.string   "string",     limit: 255
    t.text     "text",       limit: 65535
    t.string   "photo",      limit: 255
    t.string   "state",      limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "infos", ["order_id"], name: "index_infos_on_order_id", using: :btree

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

  create_table "money_receipts", force: :cascade do |t|
    t.integer  "order_id",    limit: 4
    t.decimal  "amount",                  precision: 12, scale: 2, default: 0.0
    t.decimal  "bank_charge",             precision: 12, scale: 2, default: 0.0
    t.date     "date"
    t.string   "attach",      limit: 255
    t.string   "state",       limit: 255
    t.datetime "created_at",                                                     null: false
    t.datetime "updated_at",                                                     null: false
  end

  add_index "money_receipts", ["order_id"], name: "index_money_receipts_on_order_id", using: :btree

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
    t.datetime "created_at",                                                           null: false
    t.datetime "updated_at",                                                           null: false
    t.string   "deliver",         limit: 255,                          default: "未快递"
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
    t.integer  "progress_bar",      limit: 4,     default: 0
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
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.string   "label",             limit: 255
    t.string   "title4",            limit: 255
    t.string   "content4",          limit: 255
    t.string   "title5",            limit: 255
    t.string   "content5",          limit: 255
    t.string   "title6",            limit: 255
    t.string   "content6",          limit: 255
    t.string   "title7",            limit: 255
    t.string   "content7",          limit: 255
    t.text     "rate",              limit: 65535
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
    t.string   "number",     limit: 255
  end

  add_foreign_key "individuals", "users"
  add_foreign_key "info_fields", "products"
  add_foreign_key "infos", "orders"
  add_foreign_key "institutions", "users"
  add_foreign_key "money_receipts", "orders"
  add_foreign_key "orders", "products"
  add_foreign_key "orders", "users"
  add_foreign_key "products", "funds"
  add_foreign_key "rois", "products"
end
