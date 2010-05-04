class Composition < ActiveRecord::Base
  include Composition::HandIn
  include Composition::Graded

  extend ActiveRecord::Denormalization
  belongs_to :studier, denormalize: :student
  belongs_to :assignment, denormalize: :course
  has_many :annotations

  before_save :if => :original_changed? do
    self.annotated = original
  end
end