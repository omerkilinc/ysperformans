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

ActiveRecord::Schema[7.1].define(version: 2023_12_28_120335) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "business_processes", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "departments", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "performance_departments", id: false, force: :cascade do |t|
    t.bigint "department_id"
    t.bigint "performance_indicator_id"
    t.index ["department_id"], name: "index_performance_departments_on_department_id"
    t.index ["performance_indicator_id"], name: "index_performance_departments_on_performance_indicator_id"
  end

  create_table "performance_indicators", force: :cascade do |t|
    t.bigint "business_process_id"
    t.bigint "responsible_id"
    t.bigint "standart_id"
    t.string "name"
    t.text "description"
    t.integer "indicator_status", default: 2
    t.integer "measured_method"
    t.integer "measurement_criteria"
    t.integer "value_parameter"
    t.date "targeted_date"
    t.integer "targeted_value"
    t.string "last_measured_value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_process_id"], name: "index_performance_indicators_on_business_process_id"
    t.index ["responsible_id"], name: "index_performance_indicators_on_responsible_id"
    t.index ["standart_id"], name: "index_performance_indicators_on_standart_id"
  end

  create_table "performance_measurements", force: :cascade do |t|
    t.bigint "performance_indicator_id"
    t.bigint "user_id"
    t.date "start_date"
    t.date "end_date"
    t.date "target_date"
    t.integer "measured_value"
    t.date "measurement_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["performance_indicator_id"], name: "index_performance_measurements_on_performance_indicator_id"
    t.index ["user_id"], name: "index_performance_measurements_on_user_id"
  end

  create_table "standarts", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "username"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "performance_departments", "departments"
  add_foreign_key "performance_departments", "performance_indicators"
  add_foreign_key "performance_indicators", "business_processes"
  add_foreign_key "performance_indicators", "standarts"
  add_foreign_key "performance_indicators", "users", column: "responsible_id"
  add_foreign_key "performance_measurements", "performance_indicators"
  add_foreign_key "performance_measurements", "users"
end
