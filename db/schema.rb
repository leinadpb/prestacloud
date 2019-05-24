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

ActiveRecord::Schema.define(version: 2019_05_24_202833) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts_receivables", force: :cascade do |t|
    t.string "status"
    t.decimal "amount", precision: 7, scale: 2
    t.date "expiration_date"
    t.boolean "payed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "payment_receipt_id"
    t.index ["payment_receipt_id"], name: "index_accounts_receivables_on_payment_receipt_id"
  end

  create_table "article_states", force: :cascade do |t|
    t.string "descripcion"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "article_types", force: :cascade do |t|
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "frecuency_id"
    t.index ["frecuency_id"], name: "index_article_types_on_frecuency_id"
  end

  create_table "articles", force: :cascade do |t|
    t.string "description"
    t.decimal "real_price", precision: 7, scale: 2
    t.decimal "agreement_price", precision: 7, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "article_state_id"
    t.bigint "article_type_id"
    t.index ["article_state_id"], name: "index_articles_on_article_state_id"
    t.index ["article_type_id"], name: "index_articles_on_article_type_id"
  end

  create_table "clients", force: :cascade do |t|
    t.string "goverment_id"
    t.string "phone"
    t.string "first_name"
    t.string "last_name"
    t.date "birthdate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "frecuencies", force: :cascade do |t|
    t.string "description"
    t.decimal "value", precision: 7, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "jwt_blacklist", force: :cascade do |t|
    t.string "jti", null: false
    t.index ["jti"], name: "index_jwt_blacklist_on_jti"
  end

  create_table "loan_details", force: :cascade do |t|
    t.date "expiration_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "loans", force: :cascade do |t|
    t.decimal "amount", precision: 7, scale: 2
    t.string "status"
    t.decimal "tax", precision: 7, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "client_id"
    t.bigint "user_id"
    t.bigint "loan_detail_id"
    t.index ["client_id"], name: "index_loans_on_client_id"
    t.index ["loan_detail_id"], name: "index_loans_on_loan_detail_id"
    t.index ["user_id"], name: "index_loans_on_user_id"
  end

  create_table "log_articles", force: :cascade do |t|
    t.integer "previous_state"
    t.integer "next_state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "article_id"
    t.index ["article_id"], name: "index_log_articles_on_article_id"
  end

  create_table "payment_receipt_details", force: :cascade do |t|
    t.decimal "amount", precision: 7, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payment_receipts", force: :cascade do |t|
    t.decimal "amount", precision: 7, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "payment_receipt_detail_id"
    t.index ["payment_receipt_detail_id"], name: "index_payment_receipts_on_payment_receipt_detail_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.bigint "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource_type_and_resource_id"
  end

  create_table "sell_details", force: :cascade do |t|
    t.decimal "amount", precision: 7, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sells", force: :cascade do |t|
    t.decimal "amount", precision: 7, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

  add_foreign_key "accounts_receivables", "payment_receipts"
  add_foreign_key "article_types", "frecuencies"
  add_foreign_key "articles", "article_states"
  add_foreign_key "articles", "article_types"
  add_foreign_key "loans", "clients"
  add_foreign_key "loans", "loan_details"
  add_foreign_key "loans", "users"
  add_foreign_key "log_articles", "articles"
  add_foreign_key "payment_receipts", "payment_receipt_details"
end
