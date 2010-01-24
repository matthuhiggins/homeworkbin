class CreateEnrollments < ActiveRecord::Migration
  def self.up
    create_table :enrollments do |t|
      t.string    :email,             :null => false
      t.integer   :course_id,         :null => false
      t.string    :token,             :null => false
      t.timestamps
    end
    
    add_index :enrollments, [:course_id, :email], :unique => true
    add_index :enrollments, :token, :unique => true
    add_foreign_key :enrollments, :courses,     :dependent => :delete
  end

  def self.down
  end
end
