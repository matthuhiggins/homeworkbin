class CreateCompositions < ActiveRecord::Migration
  def self.up
    create_table :compositions do |t|
      t.integer :student_id,      :null => false
      t.integer :learner_id,      :null => false
      t.integer :assignment_id,   :null => false
      t.text    :paper,           :null => false
      t.timestamps
    end
    
    add_foreign_key :compositions, :people,      :dependent => :delete, :column => 'student_id'
    add_foreign_key :compositions, :learners,    :dependent => :delete
    add_foreign_key :compositions, :assignments, :dependent => :delete
  end

  def self.down
    drop_table :compositions
  end
end
