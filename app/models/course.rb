class Course < ActiveRecord::Base
  include Course::TimeZoneInfo

  validates_presence_of :name
  
  extend ActiveRecord::DateValidation
  validates_date_format :start_date, :end_date

  belongs_to :teacher

  has_many :studiers
  has_many :students, through: :studiers, order: 'full_name'
  has_many :assignments
  has_many :compositions
  has_many :enrollments, extend: Enrollment::Matriculation

  after_create do |course|
    course.teacher.decrement! :courses_available
    course.teacher.increment! :courses_created
  end

  def submissions
    compositions.handed_in
  end
  
  def last
    @last ||= teacher.teaching.last
  end
end