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

ActiveRecord::Schema.define(version: 2020_11_22_010905) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "address_clients", force: :cascade do |t|
    t.string "number_cep"
    t.string "neighborhood"
    t.string "street"
    t.string "number_residence"
    t.string "complement"
    t.bigint "cart_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["cart_id"], name: "index_address_clients_on_cart_id"
  end

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "carts", force: :cascade do |t|
    t.decimal "price_shipping", precision: 8, scale: 2
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "clients", force: :cascade do |t|
    t.string "cpf_number"
    t.string "name"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_clients_on_email", unique: true
    t.index ["reset_password_token"], name: "index_clients_on_reset_password_token", unique: true
  end

  create_table "discounts", force: :cascade do |t|
    t.string "title"
    t.datetime "end_time"
    t.datetime "start_time"
    t.integer "status"
    t.float "value", default: 1.0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "order_products", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.integer "quantity", default: 0
    t.bigint "cart_id", null: false
    t.bigint "discount_id"
    t.decimal "price_paid", precision: 8, scale: 2
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "color"
    t.string "size"
    t.index ["cart_id"], name: "index_order_products_on_cart_id"
    t.index ["discount_id"], name: "index_order_products_on_discount_id"
    t.index ["product_id"], name: "index_order_products_on_product_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "type_of_payment"
    t.string "comment"
    t.bigint "cart_id", null: false
    t.bigint "store_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "client_name"
    t.integer "type_of_shipping"
    t.index ["cart_id"], name: "index_orders_on_cart_id"
    t.index ["store_id"], name: "index_orders_on_store_id"
  end

  create_table "payments", force: :cascade do |t|
    t.integer "status"
    t.bigint "store_id", null: false
    t.datetime "payday"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["store_id"], name: "index_payments_on_store_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "title"
    t.float "price", default: 0.0
    t.string "description", null: false
    t.bigint "subcategory_id", null: false
    t.integer "visibility", default: 1
    t.integer "status"
    t.integer "quantity", default: 1
    t.json "images"
    t.bigint "store_id", null: false
    t.string "thumbnail"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "slug"
    t.bigint "store_category_id"
    t.index ["slug"], name: "index_products_on_slug", unique: true
    t.index ["store_category_id"], name: "index_products_on_store_category_id"
    t.index ["store_id"], name: "index_products_on_store_id"
    t.index ["subcategory_id"], name: "index_products_on_subcategory_id"
  end

  create_table "products_discounts", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.bigint "discount_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["discount_id"], name: "index_products_discounts_on_discount_id"
    t.index ["product_id"], name: "index_products_discounts_on_product_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.string "cep_number"
    t.string "state"
    t.string "city"
    t.string "street"
    t.string "neighborhood"
    t.string "number_residence"
    t.string "complement"
    t.string "thumbnail"
    t.boolean "credit_or_debit_card_payment_machine"
    t.boolean "cash_payment"
    t.boolean "billet_payment"
    t.boolean "transfer_payment"
    t.string "phone_number_whatsapp"
    t.string "link_to_facebook"
    t.string "link_to_instagram"
    t.bigint "store_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["store_id"], name: "index_profiles_on_store_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.bigint "client_id", null: false
    t.bigint "product_id", null: false
    t.string "text"
    t.integer "value", default: 5
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["client_id"], name: "index_reviews_on_client_id"
    t.index ["product_id"], name: "index_reviews_on_product_id"
  end

  create_table "shipping_by_neighborhoods", force: :cascade do |t|
    t.string "neighborhood"
    t.float "price", default: 0.0
    t.bigint "shipping_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["shipping_id"], name: "index_shipping_by_neighborhoods_on_shipping_id"
  end

  create_table "shippings", force: :cascade do |t|
    t.float "price_for_free_shipping"
    t.string "delivery_policy"
    t.bigint "store_id", null: false
    t.integer "opening_time_hour"
    t.integer "opening_time_second"
    t.integer "closing_time_hour"
    t.integer "closing_time_second"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "daily_delivery"
    t.boolean "weekly_delivery"
    t.boolean "reserve_delivery"
    t.boolean "pick_up_at_the_store"
    t.index ["store_id"], name: "index_shippings_on_store_id"
  end

  create_table "store_categories", force: :cascade do |t|
    t.string "title"
    t.bigint "store_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["store_id"], name: "index_store_categories_on_store_id"
  end

  create_table "stores", force: :cascade do |t|
    t.string "title"
    t.string "name"
    t.string "surname"
    t.string "cpf_number"
    t.string "status"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "slug"
    t.index ["email"], name: "index_stores_on_email", unique: true
    t.index ["reset_password_token"], name: "index_stores_on_reset_password_token", unique: true
    t.index ["slug"], name: "index_stores_on_slug", unique: true
  end

  create_table "subcategories", force: :cascade do |t|
    t.string "title"
    t.bigint "category_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_subcategories_on_category_id"
  end

  create_table "type_products", force: :cascade do |t|
    t.string "size"
    t.string "color"
    t.boolean "visibility"
    t.bigint "product_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_id"], name: "index_type_products_on_product_id"
  end

  add_foreign_key "address_clients", "carts"
  add_foreign_key "order_products", "carts"
  add_foreign_key "order_products", "discounts"
  add_foreign_key "order_products", "products"
  add_foreign_key "orders", "carts"
  add_foreign_key "orders", "stores"
  add_foreign_key "payments", "stores"
  add_foreign_key "products", "store_categories"
  add_foreign_key "products", "stores"
  add_foreign_key "products", "subcategories"
  add_foreign_key "products_discounts", "discounts"
  add_foreign_key "products_discounts", "products"
  add_foreign_key "profiles", "stores"
  add_foreign_key "reviews", "clients"
  add_foreign_key "reviews", "products"
  add_foreign_key "shipping_by_neighborhoods", "shippings"
  add_foreign_key "shippings", "stores"
  add_foreign_key "store_categories", "stores"
  add_foreign_key "subcategories", "categories"
  add_foreign_key "type_products", "products"
end
