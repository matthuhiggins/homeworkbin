class Composition < ActiveRecord::Base
  extend Concerns::Denormalization

  belongs_to :learner, :denormalize => :student
  belongs_to :assignment, :denormalize => :course
end