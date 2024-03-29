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

ActiveRecord::Schema.define(:version => 20120315065303) do

  create_table "accounts", :force => true do |t|
    t.string   "login"
    t.string   "password"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "homes", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "projects", :force => true do |t|
    t.string   "projectname"
    t.string   "subprojectof"
    t.string   "description"
    t.string   "identifier"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "syscodes", :force => true do |t|
    t.string   "syscode"
    t.string   "syscode_desc"
    t.integer  "isactive"
    t.integer  "fksyscodeparent"
    t.integer  "createdby"
    t.datetime "datecreated"
    t.datetime "datemodified"
    t.integer  "modifiedby"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "email"
    t.string   "language"
    t.string   "password"
    t.string   "confirmation"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

end
