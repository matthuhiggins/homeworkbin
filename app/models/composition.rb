class Composition < ActiveRecord::Base
  include Composition::HandIn

  extend ActiveRecord::Denormalization
  belongs_to :studier, denormalize: :student
  belongs_to :assignment, denormalize: :course

  before_save :if => :original_changed? do
    self.annotated = original
  end
  
  scope :ungraded, where(graded_at: nil)
  scope :graded, where('graded_at is not null')
end