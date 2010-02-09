class Course < ActiveRecord::Base
  extend ActiveRecord::DateValidation
  extend ActiveSupport::Memoizable
  
  belongs_to :teacher
  has_many :studiers
  has_many :students, :through => :studiers
  has_many :assignments
  has_many :enrollments, :extend => Enrollment::Matriculation

  validates_presence_of :name

  validates_date_format :start_date, :end_date
  
  after_create do |course|
    course.teacher.decrement! :courses_available
  end

  def last
    @last ||= teacher.teaching.last
  end

  def date_range
    start_date..end_date
  end
end