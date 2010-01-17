class Course < ActiveRecord::Base
  belongs_to :teacher
  has_many :learners
  has_many :students, :through => :learners
  has_many :assignments
  
  validates_presence_of :name
end