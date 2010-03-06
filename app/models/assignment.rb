class Assignment < ActiveRecord::Base
  include Assignment::Handout
  include Assignment::Due

  extend ActiveSupport::Concern

  has_many :submissions
  belongs_to :course

  delegate :teacher, :to => :course

  def last
    @last ||= course.assignments.last
  end
end