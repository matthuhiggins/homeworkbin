class Assignment < ActiveRecord::Base
  belongs_to :course
  has_many :compositions

  validates_presence_of :name
  
  after_create :notify_students
  
  private
    def notify_students
      course.students.each do |student|
        Mailer.deliver_assignment self, student
      end
    end
end