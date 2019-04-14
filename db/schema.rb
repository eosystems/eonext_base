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

ActiveRecord::Schema.define(version: 0) do

  create_table "corporation_relations", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=COMPACT", force: :cascade do |t|
    t.integer "ancestor", null: false
    t.integer "descendant", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["ancestor"], name: "index_corporation_relations_on_ancestor"
    t.index ["descendant"], name: "index_corporation_relations_on_descendant"
  end

  create_table "corporations", primary_key: "corporation_id", id: :integer, default: nil, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=COMPACT", force: :cascade do |t|
    t.string "corporation_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "delayed_jobs", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT", comment: "Delayed Job", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at", comment: "作成日時"
    t.datetime "updated_at", comment: "更新日時"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "users", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=COMPACT", force: :cascade do |t|
    t.string "character_id"
    t.string "name"
    t.integer "corporation_id"
    t.integer "alliance_id"
    t.boolean "is_main"
    t.integer "main_character_id"
    t.integer "sign_in_count", default: 0, null: false
    t.string "login_token"
    t.string "access_token"
    t.text "refresh_token"
    t.datetime "expire"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
