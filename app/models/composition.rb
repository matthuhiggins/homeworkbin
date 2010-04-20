class Composition < ActiveRecord::Base
  include Composition::HandIn

  extend ActiveRecord::Denormalization
  belongs_to :studier, denormalize: :student
  belongs_to :assignment, denormalize: :course
  
  scope :ungraded, where(graded: false)
  scope :graded, where(graded: true)
end