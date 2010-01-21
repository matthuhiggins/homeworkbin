class Course < ActiveRecord::Base
  belongs_to :teacher, :counter_cache => :courses_taught
  has_many :studiers
  has_many :students, :through => :studiers
  has_many :assignments
  
  validates_presence_of :name
  
  after_create do |course|
    course.teacher.decrement! :courses_available
  end
end