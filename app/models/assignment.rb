class Assignment < ActiveRecord::Base
  include Assignment::Handout
  include Assignment::Due

  has_many :compositions
  belongs_to :course

  delegate :teacher, :to => :course

  validates_presence_of :name

  def previous
    @previous ||= course.assignments.last
  end
end