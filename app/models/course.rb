class Course < ActiveRecord::Base
  include ActiveRecord::TimeZoneInfo

  validates_presence_of :name
  
  extend ActiveRecord::DateValidation
  validates_date_format :start_date, :end_date

  belongs_to :teacher

  has_many :studiers
  has_many :students, :through => :studiers, :order => 'full_name'
  has_many :assignments
  has_many :submissions
  has_many :enrollments, :extend => Enrollment::Matriculation


  after_create do |course|
    course.teacher.decrement! :courses_available
    course.teacher.increment! :courses_created
  end

  before_create(:unless => :time_zone) do |course|
    course.time_zone = 'Pacific Time (US & Canada)'
  end

  def time_zone
    self[:time_zone] ||= 'Pacific Time (US & Canada)'
  end

  def last
    @last ||= teacher.teaching.last
  end

  def date_range
    start_date..end_date
  end
end