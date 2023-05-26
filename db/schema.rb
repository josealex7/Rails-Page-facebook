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

ActiveRecord::Schema[7.0].define(version: 2023_05_19_161128) do
  create_table "customers", force: :cascade do |t|
    t.string "stripe_customer_id"
    t.string "name"
    t.string "email"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_customers_on_user_id"
  end

  create_table "friendships", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "friend_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["friend_id"], name: "index_friendships_on_friend_id"
    t.index ["user_id"], name: "index_friendships_on_user_id"
  end

  create_table "histories", force: :cascade do |t|
    t.integer "user_id"
    t.text "image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_histories_on_user_id"
  end

  create_table "images", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "url", default: "", null: false
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_images_on_user_id"
  end

  create_table "likes", force: :cascade do |t|
    t.boolean "is_like"
    t.integer "user_id"
    t.integer "publication_id"
    t.index ["publication_id"], name: "index_likes_on_publication_id"
    t.index ["user_id", "publication_id"], name: "index_likes_on_user_id_and_publication_id", unique: true
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "main_comments", force: :cascade do |t|
    t.text "text_comment", null: false
    t.integer "publication_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["publication_id"], name: "index_main_comments_on_publication_id"
    t.index ["user_id"], name: "index_main_comments_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "message"
    t.integer "sender_id", null: false
    t.integer "receiver_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "publication_shares", force: :cascade do |t|
    t.integer "publication_id", null: false
    t.integer "publicationshare_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["publication_id"], name: "index_publication_shares_on_publication_id"
    t.index ["publicationshare_id"], name: "index_publication_shares_on_publicationshare_id"
  end

  create_table "publications", force: :cascade do |t|
    t.string "description"
    t.integer "user_id"
    t.integer "image_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["image_id"], name: "index_publications_on_image_id"
    t.index ["user_id"], name: "index_publications_on_user_id"
  end

  create_table "userpages", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "userpage_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_userpages_on_user_id"
    t.index ["userpage_id"], name: "index_userpages_on_userpage_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "nopassword"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "birthday"
    t.string "sex"
    t.string "first_name"
    t.string "last_name"
    t.integer "image_profile_id"
    t.integer "image_portada_id"
    t.string "user_type", default: "user", null: false
    t.text "token"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["image_portada_id"], name: "index_users_on_image_portada_id"
    t.index ["image_profile_id"], name: "index_users_on_image_profile_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "customers", "users"
  add_foreign_key "friendships", "users"
  add_foreign_key "friendships", "users", column: "friend_id"
  add_foreign_key "histories", "users"
  add_foreign_key "images", "users"
  add_foreign_key "publication_shares", "publications"
  add_foreign_key "publication_shares", "publications", column: "publicationshare_id"
  add_foreign_key "publications", "users"
  add_foreign_key "userpages", "users"
  add_foreign_key "userpages", "users", column: "userpage_id"
end
