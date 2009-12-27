class Assignment < ActiveRecord::Base
  belongs_to :course
  has_many :submissions

  validatates_presence_of :name
end