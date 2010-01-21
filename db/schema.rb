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

ActiveRecord::Schema.define(:version => 20091226234927) do

  create_table "assignments", :force => true do |t|
    t.string   "name",        :null => false
    t.text     "description", :null => false
    t.datetime "due",         :null => false
    t.integer  "course_id",   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "compositions", :force => true do |t|
    t.integer  "learner_id",    :null => false
    t.integer  "student_id",    :null => false
    t.integer  "assignment_id", :null => false
    t.integer  "course_id",     :null => false
    t.text     "paper",         :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "courses", :force => true do |t|
    t.string   "name",                          :null => false
    t.text     "description",                   :null => false
    t.datetime "start",                         :null => false
    t.datetime "end",                           :null => false
    t.integer  "teacher_id",                    :null => false
    t.integer  "students_count", :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "enrollments", :force => true do |t|
    t.string   "email",      :null => false
    t.integer  "course_id",  :null => false
    t.integer  "teacher_id", :null => false
    t.string   "token",      :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "enrollments", ["course_id", "email"], :name => "index_enrollments_on_course_id_and_email", :unique => true
  add_index "enrollments", ["token"], :name => "index_enrollments_on_token", :unique => true

  create_table "learners", :force => true do |t|
    t.integer "student_id", :null => false
    t.integer "course_id",  :null => false
  end

  create_table "lost_passwords", :force => true do |t|
    t.integer  "person_id",  :null => false
    t.string   "token",      :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "people", :force => true do |t|
    t.string   "email",                                                :null => false
    t.string   "full_name",                                            :null => false
    t.string   "encrypted_password", :limit => 128,                    :null => false
    t.string   "salt",               :limit => 128,                    :null => false
    t.string   "remember_token",     :limit => 128
    t.integer  "courses_taught",                    :default => 0,     :null => false
    t.integer  "courses_learned",                   :default => 0,     :null => false
    t.integer  "courses_available",                 :default => 0,     :null => false
    t.boolean  "started_as_teacher",                :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "people", ["email"], :name => "index_people_on_email", :unique => true
  add_index "people", ["remember_token"], :name => "index_people_on_remember_token", :unique => true

  create_table "registrations", :force => true do |t|
    t.string   "email",                     :null => false
    t.string   "full_name",                 :null => false
    t.string   "token",      :limit => 128, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "registrations", ["token"], :name => "index_registrations_on_token", :unique => true

end
