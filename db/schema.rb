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

ActiveRecord::Schema.define(:version => 20120130114333) do

  create_table "admins", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
  end

  add_index "admins", ["email"], :name => "index_admins_on_email", :unique => true
  add_index "admins", ["reset_password_token"], :name => "index_admins_on_reset_password_token", :unique => true

  create_table "asset_employee_mappings", :force => true do |t|
    t.integer  "asset_id"
    t.integer  "employee_id"
    t.datetime "date_issued"
    t.datetime "date_returned"
    t.text     "remark"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "assignment_type"
    t.boolean  "is_active",       :default => true
  end

  add_index "asset_employee_mappings", ["asset_id"], :name => "index_asset_employee_mappings_on_asset_id"
  add_index "asset_employee_mappings", ["employee_id"], :name => "index_asset_employee_mappings_on_employee_id"

  create_table "assets", :force => true do |t|
    t.string   "name"
    t.string   "status"
    t.decimal  "cost",            :precision => 12, :scale => 2
    t.string   "serial_number"
    t.datetime "purchase_date"
    t.text     "additional_info"
    t.text     "description"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "vendor"
    t.string   "currency_unit"
  end

  add_index "assets", ["resource_id", "resource_type"], :name => "index_assets_on_resource_id_and_resource_type"

  create_table "assets_tags", :id => false, :force => true do |t|
    t.integer "asset_id"
    t.integer "tag_id"
  end

  add_index "assets_tags", ["asset_id"], :name => "index_assets_tags_on_asset_id"
  add_index "assets_tags", ["tag_id"], :name => "index_assets_tags_on_tag_id"

  create_table "employees", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.integer  "employee_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "employees", ["name"], :name => "index_employees_on_name"

  create_table "laptops", :force => true do |t|
    t.string   "operating_system"
    t.boolean  "has_bag"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mobile_phones", :force => true do |t|
    t.string   "operating_system"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "network_devices", :force => true do |t|
    t.string   "location"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tags", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description"
  end

end
