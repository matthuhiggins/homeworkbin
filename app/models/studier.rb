class Studier < ActiveRecord::Base
  belongs_to :course
  belongs_to :student
  has_many :compositions
  
  delegate :teacher, :to => :course
  delegate :full_name, :email, :to => :student
end