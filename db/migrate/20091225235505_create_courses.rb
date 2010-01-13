class CreateCourses < ActiveRecord::Migration
  def self.up
    create_table :courses do |t|
      t.string    :name,        :null => false
      t.text      :description, :null => false
      t.datetime  :start,       :null => false
      t.datetime  :end,         :null => false
      t.integer   :teacher_id,  :null => false
      t.timestamps
    end
    
    add_foreign_key :courses, :people, :dependent => :delete, :column => 'teacher_id'
  end

  def self.down
    drop_table :courses
  end
end
