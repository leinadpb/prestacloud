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

ActiveRecord::Schema.define(version: 2019_05_24_161311) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts_receivables", force: :cascade do |t|
    t.string "status"
    t.decimal "amount", precision: 7, scale: 2
    t.date "expiration_date"
    t.boolean "payed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "article_states", force: :cascade do |t|
    t.string "descripcion"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "articles", force: :cascade do |t|
    t.string "description"
    t.decimal "real_price", precision: 7, scale: 2
    t.decimal "agreement_price", precision: 7, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
  end

  create_table "log_articles", force: :cascade do |t|
    t.integer "previous_state"
    t.integer "next_state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

end
