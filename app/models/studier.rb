class Studier < ActiveRecord::Base
  belongs_to :course
  belongs_to :student
  has_many :compositions
  
  delegate :teacher, to: :course
  delegate :full_name, :email, to: :student
  
  def submission_for(assignment)
    submissions_by_assignment_id[assignment.id]
  end
  
  def submissions
    compositions.handed_in
  end
  
  private
    def submissions_by_assignment_id
      @submissions_by_assignment_id ||= submissions.index_by(&:assignment_id)
    end
end