class CreateCourses < ActiveRecord::Migration
  def self.up
    create_table :courses do |t|
      t.string    :name,            :null => false
      t.date      :start_date,      :null => false
      t.date      :end_date,        :null => false
      t.integer   :teacher_id,      :null => false
      t.string    :time_zone,       :null => false
      t.timestamps
    end
    
    add_foreign_key :courses, :people, :dependent => :delete, :column => 'teacher_id'
  end

  def self.down
    drop_table :courses
  end
end
