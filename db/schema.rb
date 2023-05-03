# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_05_03_134510) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "collars", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "last_latitude"
    t.string "last_longitude"
    t.uuid "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_collars_on_user_id"
  end

  create_table "group_policies", force: :cascade do |t|
    t.string "name"
    t.integer "user_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_type"], name: "index_group_policies_on_user_type"
  end

  create_table "group_policy_permissions", force: :cascade do |t|
    t.bigint "permission_id", null: false
    t.bigint "group_policy_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_policy_id"], name: "index_group_policy_permissions_on_group_policy_id"
    t.index ["permission_id"], name: "index_group_policy_permissions_on_permission_id"
  end

  create_table "orders", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "product_id", null: false
    t.uuid "user_id"
    t.string "tracking_code"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_orders_on_product_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "payments", force: :cascade do |t|
    t.integer "type"
    t.boolean "paid"
    t.datetime "payday"
    t.integer "status"
    t.uuid "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "due_date"
    t.string "card_holder"
    t.string "card_number"
    t.string "expiration_month"
    t.string "expiration_year"
    t.string "security_code"
    t.index ["user_id"], name: "index_payments_on_user_id"
  end

  create_table "permissions", force: :cascade do |t|
    t.string "resource", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["resource"], name: "index_permissions_on_resource"
  end

  create_table "plans", force: :cascade do |t|
    t.string "name"
    t.decimal "price"
    t.integer "type_plan"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "months"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.decimal "price"
    t.text "description"
    t.integer "product_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "purchased_plans", force: :cascade do |t|
    t.string "name"
    t.decimal "price"
    t.integer "type_plan"
    t.uuid "user_id"
    t.boolean "promotion"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "months"
    t.bigint "plan_id"
    t.integer "status"
    t.date "due_date"
    t.index ["plan_id"], name: "index_purchased_plans_on_plan_id"
    t.index ["user_id"], name: "index_purchased_plans_on_user_id"
  end

  create_table "purchased_products", force: :cascade do |t|
    t.string "name"
    t.decimal "price"
    t.boolean "promotion"
    t.integer "status"
    t.integer "product_type"
    t.bigint "product_id", null: false
    t.uuid "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_purchased_products_on_product_id"
    t.index ["user_id"], name: "index_purchased_products_on_user_id"
  end

  create_table "user_login_logs", force: :cascade do |t|
    t.datetime "last_login_at"
    t.string "email"
    t.string "user_agent"
    t.string "ip_address"
    t.uuid "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_login_logs_on_user_id"
  end

  create_table "user_permissions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.bigint "permission_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["permission_id"], name: "index_user_permissions_on_permission_id"
    t.index ["user_id"], name: "index_user_permissions_on_user_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", limit: 100, null: false
    t.string "email", limit: 200, null: false
    t.string "user_type", limit: 100, null: false
    t.integer "status", default: 0, null: false
    t.string "password_digest", null: false
    t.string "password_reset_token"
    t.string "avatar"
    t.string "phone"
    t.datetime "password_token_expiry"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "cep"
    t.string "city"
    t.string "address"
    t.string "neighborhood"
    t.string "complement"
    t.integer "gender"
    t.date "birth_date"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "collars", "users"
  add_foreign_key "group_policy_permissions", "group_policies"
  add_foreign_key "group_policy_permissions", "permissions"
  add_foreign_key "orders", "products"
  add_foreign_key "orders", "users"
  add_foreign_key "payments", "users"
  add_foreign_key "purchased_plans", "plans"
  add_foreign_key "purchased_plans", "users"
  add_foreign_key "purchased_products", "products"
  add_foreign_key "purchased_products", "users"
  add_foreign_key "user_login_logs", "users"
  add_foreign_key "user_permissions", "permissions"
  add_foreign_key "user_permissions", "users"
end
