class Composition < ActiveRecord::Base
  extend Concerns::Denormalization

  belongs_to :studier, :denormalize => :student
  belongs_to :assignment, :denormalize => :course
end