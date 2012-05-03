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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120503082950) do

  create_table "comment_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.string   "name"
    t.text     "value"
    t.integer  "register_id"
    t.integer  "comment_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "page_text_templates", :force => true do |t|
    t.text     "template_text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "plays", :force => true do |t|
    t.string   "author"
    t.string   "title"
    t.string   "genre"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "register_contributors", :force => true do |t|
    t.integer  "register_id"
    t.integer  "task_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "register_images", :force => true do |t|
    t.string   "filepath"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "register_periods", :force => true do |t|
    t.string   "period"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "register_plays", :force => true do |t|
    t.integer  "register_id"
    t.integer  "play_id"
    t.boolean  "firstrun"
    t.string   "newactor"
    t.string   "actorrole"
    t.integer  "firstrun_perfnum"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "ordering"
  end

  create_table "register_tasks", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "register_type_seating_categories", :force => true do |t|
    t.integer  "register_type_id"
    t.integer  "seating_category_id"
    t.integer  "ordering",            :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "registers", :force => true do |t|
    t.datetime "date"
    t.string   "weekday"
    t.string   "season"
    t.integer  "register_num"
    t.text     "payment_notes"
    t.text     "page_text"
    t.integer  "total_receipts_recorded_l"
    t.integer  "total_receipts_recorded_s"
    t.integer  "representation"
    t.string   "signatory"
    t.text     "misc_notes"
    t.text     "for_editor_notes"
    t.boolean  "ouverture"
    t.boolean  "cloture"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "register_image_id"
    t.integer  "register_period_id"
    t.integer  "verification_state_id"
  end

  create_table "seating_categories", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ticket_sales", :force => true do |t|
    t.integer  "total_sold",          :default => 0
    t.integer  "register_id",         :default => 0
    t.integer  "seating_category_id", :default => 0
    t.integer  "price_per_ticket_l",  :default => 0
    t.integer  "price_per_ticket_s",  :default => 0
    t.integer  "recorded_total_l",    :default => 0
    t.integer  "recorded_total_s",    :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "password_salt",                       :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "shortname"
    t.string   "last_name"
    t.string   "first_name"
    t.text     "bio"
    t.string   "institution"
    t.string   "institution_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "verification_states", :force => true do |t|
    t.string "name"
    t.string "description"
  end

  create_table "weekday_ordering", :force => true do |t|
    t.string  "name"
    t.integer "ordering"
  end

end
