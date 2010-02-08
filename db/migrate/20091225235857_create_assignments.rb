class CreateAssignments < ActiveRecord::Migration
  def self.up
    create_table :assignments do |t|
      t.string    :name,          :null => false
      t.text      :description,   :null => true
      t.date      :due_date,      :null => false
      t.integer   :due_minutes,   :null => true
      t.integer   :course_id,     :null => false
      t.integer   :handout_count, :null => false, :default => 0
      t.timestamps
    end
    
    add_foreign_key :assignments, :courses, :dependent => :delete
  end

  def self.down
    drop_table :homeworks
  end
end
