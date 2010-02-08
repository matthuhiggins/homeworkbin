class Assignment < ActiveRecord::Base
  include Assignment::Handout
  include Assignment::Due

  extend ActiveRecord::Prior

  has_many :compositions
  belongs_to :course

  delegate :teacher, :to => :course

  validates_presence_of :name
end