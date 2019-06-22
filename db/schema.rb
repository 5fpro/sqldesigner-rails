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

ActiveRecord::Schema.define(version: 2019_06_22_031928) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "hstore"
  enable_extension "pg_trgm"
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "activities", force: :cascade do |t|
    t.string "actor_type"
    t.integer "actor_id"
    t.string "action"
    t.string "target_type"
    t.integer "target_id"
    t.date "acted_on"
    t.json "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["acted_on"], name: "index_activities_on_acted_on"
    t.index ["action"], name: "index_activities_on_action"
    t.index ["actor_type", "actor_id"], name: "index_activities_on_actor_type_and_actor_id"
    t.index ["target_type", "target_id"], name: "index_activities_on_target_type_and_target_id"
  end

  create_table "administrators", force: :cascade do |t|
    t.string "name"
    t.boolean "root", default: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
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
    t.index ["confirmation_token"], name: "index_administrators_on_confirmation_token", unique: true
    t.index ["email"], name: "index_administrators_on_email", unique: true
    t.index ["reset_password_token"], name: "index_administrators_on_reset_password_token", unique: true
  end

  create_table "attachments", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "creator_type"
    t.integer "creator_id"
    t.string "item_type"
    t.integer "item_id"
    t.string "scope"
    t.integer "sort"
    t.string "original_filename"
    t.string "stored_filename"
    t.string "file_content_type"
    t.integer "file_size"
    t.integer "image_width"
    t.integer "image_height"
    t.json "image_exif"
    t.json "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_type", "creator_id"], name: "index_attachments_on_creator_type_and_creator_id"
    t.index ["item_type", "item_id", "scope", "sort"], name: "index_attachments_on_item_type_and_item_id_and_scope_and_sort"
    t.index ["item_type", "item_id", "scope"], name: "index_attachments_on_item_type_and_item_id_and_scope"
    t.index ["item_type", "item_id", "sort"], name: "index_attachments_on_item_type_and_item_id_and_sort"
    t.index ["item_type", "item_id"], name: "index_attachments_on_item_type_and_item_id"
  end

  create_table "authorizations", force: :cascade do |t|
    t.integer "provider"
    t.string "uid"
    t.string "auth_type"
    t.integer "auth_id"
    t.text "auth_data"
    t.hstore "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["auth_type", "auth_id", "provider"], name: "index_authorizations_on_auth_type_and_auth_id_and_provider"
    t.index ["auth_type", "auth_id"], name: "index_authorizations_on_auth_type_and_auth_id"
    t.index ["provider", "uid"], name: "index_authorizations_on_provider_and_uid"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.integer "sort"
    t.index ["name"], name: "index_categories_on_name"
    t.index ["sort"], name: "index_categories_on_sort"
  end

  create_table "event_logs", force: :cascade do |t|
    t.string "event_type"
    t.string "description"
    t.string "identity"
    t.date "created_on"
    t.json "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_on"], name: "index_event_logs_on_created_on"
    t.index ["event_type", "identity"], name: "index_event_logs_on_event_type_and_identity"
    t.index ["event_type"], name: "index_event_logs_on_event_type"
  end

  create_table "notifications", force: :cascade do |t|
    t.string "sender_type"
    t.string "sender_id"
    t.string "receiver_type"
    t.string "receiver_id"
    t.string "object_type"
    t.string "object_id"
    t.string "notify_type"
    t.boolean "readed", default: false
    t.string "subject"
    t.string "body"
    t.date "created_on"
    t.json "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["body"], name: "trgm_notifications_body_idx", opclass: :gist_trgm_ops, using: :gist
    t.index ["created_on"], name: "index_notifications_on_created_on"
    t.index ["notify_type"], name: "index_notifications_on_notify_type"
    t.index ["object_type", "object_id"], name: "index_notifications_on_object_type_and_object_id"
    t.index ["readed", "receiver_type", "receiver_id"], name: "index_notifications_on_readed_and_receiver_type_and_receiver_id"
    t.index ["receiver_type", "receiver_id"], name: "index_notifications_on_receiver_type_and_receiver_id"
    t.index ["sender_type", "sender_id"], name: "index_notifications_on_sender_type_and_sender_id"
    t.index ["subject"], name: "trgm_notifications_subject_idx", opclass: :gist_trgm_ops, using: :gist
  end

  create_table "page_blocks", force: :cascade do |t|
    t.string "name"
    t.text "body"
    t.boolean "enabled", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["enabled"], name: "index_page_blocks_on_enabled"
    t.index ["name"], name: "index_page_blocks_on_name"
  end

  create_table "redactor2_assets", force: :cascade do |t|
    t.integer "user_id"
    t.string "data_file_name", null: false
    t.string "data_content_type"
    t.integer "data_file_size"
    t.integer "assetable_id"
    t.string "assetable_type", limit: 30
    t.string "type", limit: 30
    t.integer "width"
    t.integer "height"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assetable_type", "assetable_id"], name: "idx_redactor2_assetable"
    t.index ["assetable_type", "type", "assetable_id"], name: "idx_redactor2_assetable_type"
  end

  create_table "taggings", force: :cascade do |t|
    t.bigint "tag_id"
    t.string "taggable_type"
    t.bigint "taggable_id"
    t.string "tagger_type"
    t.bigint "tagger_id"
    t.string "context", limit: 128
    t.datetime "created_at"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"
    t.index ["taggable_type", "taggable_id"], name: "index_taggings_on_taggable_type_and_taggable_id"
    t.index ["tagger_type", "tagger_id"], name: "index_taggings_on_tagger_type_and_tagger_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
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
    t.string "avatar"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type", null: false
    t.integer "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object"
    t.datetime "created_at"
    t.text "object_changes"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

end
