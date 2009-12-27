# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20091226000017) do

  create_table "assignments", :force => true do |t|
    t.string   "title",       :null => false
    t.text     "description", :null => false
    t.datetime "due",         :null => false
    t.integer  "course_id",   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "courses", :force => true do |t|
    t.string   "title",       :null => false
    t.text     "description", :null => false
    t.datetime "start",       :null => false
    t.datetime "end",         :null => false
    t.integer  "teacher_id",  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "learners", :force => true do |t|
    t.integer "student_id", :null => false
    t.integer "course_id",  :null => false
  end

  create_table "people", :force => true do |t|
    t.string   "email",                                                :null => false
    t.string   "full_name",                                            :null => false
    t.string   "encrypted_password", :limit => 128,                    :null => false
    t.string   "salt",               :limit => 128,                    :null => false
    t.string   "confirmation_token", :limit => 128,                    :null => false
    t.string   "remember_token",     :limit => 128
    t.boolean  "email_confirmed",                   :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "people", ["email"], :name => "index_people_on_email"
  add_index "people", ["id", "confirmation_token"], :name => "index_people_on_id_and_confirmation_token"
  add_index "people", ["remember_token"], :name => "index_people_on_remember_token"

  create_table "submissions", :force => true do |t|
    t.integer  "student_id",    :null => false
    t.integer  "learner_id",    :null => false
    t.integer  "assignment_id", :null => false
    t.text     "paper",         :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
