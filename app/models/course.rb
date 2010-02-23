class Course < ActiveRecord::Base
  extend ActiveRecord::DateValidation
  extend ActiveSupport::Memoizable
  
  belongs_to :teacher
  delegate :time_zone, :to => :teacher
  include ActiveRecord::TimeZoneInfo

  has_many :studiers
  has_many :students, :through => :studiers, :order => 'full_name'
  has_many :assignments
  has_many :enrollments, :extend => Enrollment::Matriculation

  validates_presence_of :name

  validates_date_format :start_date, :end_date
  
  after_create do |course|
    course.teacher.decrement! :courses_available
    course.teacher.increment! :courses_created
  end

  def last
    @last ||= teacher.teaching.last
  end

  def date_range
    start_date..end_date
  end
end