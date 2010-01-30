class Course < ActiveRecord::Base
  belongs_to :teacher
  has_many :studiers
  has_many :students, :through => :studiers
  has_many :assignments
  has_many :enrollments, :extend => Enrollment::Matriculation
  
  validates_presence_of :name
  
  after_create do |course|
    course.teacher.decrement! :courses_available
  end
end