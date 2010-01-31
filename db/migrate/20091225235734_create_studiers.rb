class CreateStudiers < ActiveRecord::Migration
  def self.up
    create_table :studiers do |t|
      t.integer :student_id,  :null => false
      t.integer :course_id,   :null => false
    end
    
    add_index :studiers, [:course_id, :student_id], :unique => true
    add_foreign_key :studiers, :people,   :dependent => :delete, :column => 'student_id'
    add_foreign_key :studiers, :courses,  :dependent => :delete
  end

  def self.down
    drop_table :studiers
  end
end
