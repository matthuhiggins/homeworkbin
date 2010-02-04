class Course < ActiveRecord::Base
  belongs_to :teacher
  has_many :studiers
  has_many :students, :through => :studiers
  has_many :assignments
  has_many :enrollments, :extend => Enrollment::Matriculation
  
  validates_presence_of :name
  
  validates_each :start_date, :end_date do |course, column, value|
    begin
      !value.is_a?(Date) && Date.strptime(value, "%m/%d/%Y")
    rescue
      course.errors.add(column, 'is not mm/dd/yyyy')
    end
  end

  after_create do |course|
    course.teacher.decrement! :courses_available
  end
end