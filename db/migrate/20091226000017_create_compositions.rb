class CreateCompositions < ActiveRecord::Migration
  def self.up
    create_table :compositions do |t|
      t.integer   :studier_id,      :null => false
      t.integer   :student_id,      :null => false
      t.integer   :assignment_id,   :null => false
      t.integer   :course_id,       :null => false
      t.text      :text,            :null => false
      t.datetime  :handed_in_at,    :null => true
      t.timestamps
    end
    
    add_index :compositions, [:assignment_id, :studier_id], :unique => true
    add_foreign_key :compositions, :people,       :dependent => :delete, :column => 'student_id'
    add_foreign_key :compositions, :studiers,     :dependent => :delete
    add_foreign_key :compositions, :courses,      :dependent => :delete
    add_foreign_key :compositions, :assignments,  :dependent => :delete
  end

  def self.down
    drop_table :compositions
  end
end
