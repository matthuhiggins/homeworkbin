class Composition < ActiveRecord::Base
  extend ActiveRecord::Denormalization

  belongs_to :studier, :denormalize => :student
  belongs_to :assignment, :denormalize => :course
end