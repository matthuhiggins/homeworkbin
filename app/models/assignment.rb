class Assignment < ActiveRecord::Base
  belongs_to :course
  has_many :compositions

  validates_presence_of :name
end