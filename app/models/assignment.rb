class Assignment < ActiveRecord::Base
  belongs_to :course
  has_many :compositions

  validatates_presence_of :name
end