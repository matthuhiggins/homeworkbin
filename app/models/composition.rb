class Composition < ActiveRecord::Base
  belongs_to :learner
  belongs_to :student
  belongs_to :assignment
  belongs_to :course
  
  extend Concerns::Denormalization
  denormalizes :student, :through => :learner
  denormalizes :course, :through => :assignment
end