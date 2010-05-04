class Assignment < ActiveRecord::Base
  include Assignment::Handout
  include Assignment::Due

  validates_presence_of :name

  has_many :compositions
  belongs_to :course

  delegate :teacher, to: :course

  def submissions
    compositions.handed_in
  end

  def last
    @last ||= course.assignments.last
  end
end