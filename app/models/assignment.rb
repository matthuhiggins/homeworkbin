class Assignment < ActiveRecord::Base
  has_many :compositions
  belongs_to :course
  delegate :teacher, :to => :course
  validates_presence_of :name
  
  after_create :notify_students
  
  private
    def notify_students
      course.students.each do |student|
        Mailer.deliver_assignment self, student
      end
    end
end