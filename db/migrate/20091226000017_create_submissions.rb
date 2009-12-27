class CreateSubmissions < ActiveRecord::Migration
  def self.up
    create_table :submissions do |t|
      t.integer :student_id,      :null => false
      t.integer :learner_id,      :null => false
      t.integer :assignment_id,   :null => false
      t.text    :paper,           :null => false
      t.timestamps
    end
    
    add_foreign_key :submissions, :people,      :dependent => :delete, :column => 'student_id'
    add_foreign_key :submissions, :learners,    :dependent => :delete
    add_foreign_key :submissions, :assignments, :dependent => :delete
  end

  def self.down
    drop_table :submissions
  end
end
