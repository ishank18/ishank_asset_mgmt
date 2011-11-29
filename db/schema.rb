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

ActiveRecord::Schema.define(:version => 20111129131058) do

  create_table "asset_employee_mappings", :force => true do |t|
    t.integer  "asset_id"
    t.integer  "employee_id"
    t.datetime "date_issued"
    t.datetime "date_returned"
    t.text     "remark"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "assets", :force => true do |t|
    t.string   "name"
    t.string   "status"
    t.integer  "cost"
    t.string   "serial_number"
    t.datetime "purchase_date"
    t.text     "additional_info"
    t.text     "description"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "employees", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "loptops", :force => true do |t|
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
    t.integer  "asset_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
