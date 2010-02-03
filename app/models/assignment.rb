class Assignment < ActiveRecord::Base
  include Assignment::Handout

  has_many :compositions
  belongs_to :course

  delegate :teacher, :to => :course

  validates_presence_of :name
end