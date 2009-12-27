class CreateLearners < ActiveRecord::Migration
  def self.up
    create_table :learners do |t|
      t.integer :student_id,  :null => false
      t.integer :course_id,   :null => false
    end
    
    add_foreign_key :learners, :people,   :dependent => :delete, :column => 'student_id'
    add_foreign_key :learners, :courses,  :dependent => :delete
  end

  def self.down
    drop_table :learners
  end
end
