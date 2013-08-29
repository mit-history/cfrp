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

ActiveRecord::Schema.define(:version => 20130829210431) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "assignments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

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
    t.integer  "acts"
    t.string   "prose_vers"
    t.boolean  "prologue"
    t.boolean  "musique_danse_machine"
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
    t.integer  "register_id"
  end

  create_table "register_period_seating_categories", :force => true do |t|
    t.integer  "register_period_id"
    t.integer  "seating_category_id"
    t.integer  "ordering",            :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
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
    t.boolean  "free_access"
    t.string   "ex_attendance"
    t.string   "ex_representation"
    t.string   "ex_place"
    t.boolean  "reprise"
    t.boolean  "debut"
    t.integer  "reprise_perfnum"
  end

  create_table "register_tasks", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "registers", :force => true do |t|
    t.date     "date"
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
    t.string   "irregular_receipts_name"
    t.string   "page_de_gauche"
    t.date     "date_of_left_page_info"
  end

  create_table "roles", :force => true do |t|
    t.string "name"
    t.string "description"
  end

  create_table "seating_categories", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
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
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "password_salt",          :default => "", :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
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
    t.datetime "reset_password_sent_at"
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
