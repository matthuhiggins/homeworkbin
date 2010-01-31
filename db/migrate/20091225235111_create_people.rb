class CreatePeople < ActiveRecord::Migration
  def self.up
    create_table :people do |t|
      t.string   :email,                  :null => false
      t.string   :full_name,              :null => false
      t.string   :encrypted_password,     :null => false, :limit => 128
      t.string   :salt,                   :null => false, :limit => 128
      t.string   :remember_token,         :null => true,  :limit => 128
      t.integer  :courses_available,      :null => false, :default => 0
      t.boolean  :registered_as_teacher,  :null => false, :default => false
      t.boolean  :automatically_enroll,   :null => false, :default => true
      t.timestamps
    end

    add_index :people, :email, :unique => true
    add_index :people, :remember_token, :unique => true
  end

  def self.down
    drop_table :people
  end
end
