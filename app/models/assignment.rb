class Assignment < ActiveRecord::Base
  include Assignment::Handout
  include Assignment::Due

  has_many :compositions
  belongs_to :course

  delegate :teacher, :to => :course

  validates_presence_of :name
  
  validate :if => lambda { |assignment| assignment.due_date.present? } do |assignment|
    if assignment.course.start_date > assignment.due_date
      assignment.errors.add :due_date, 'is before this course'
    elsif assignment.course.end_date < assignment.due_date
      assignment.errors.add :due_date, 'is after this course'
    end
  end

  def last
    @last ||= course.assignments.last
  end
end