class Course < ActiveRecord::Base
  extend ActiveRecord::Previous
  
  belongs_to :teacher
  has_many :studiers
  has_many :students, :through => :studiers
  has_many :assignments
  has_many :enrollments, :extend => Enrollment::Matriculation

  validates_presence_of :name

  extend ActiveRecord::DateValidation
  validates_date_format :start_date, :end_date


  after_create do |course|
    course.teacher.decrement! :courses_available
  end
end