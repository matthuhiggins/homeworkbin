class Composition < ActiveRecord::Base
  include Composition::HandIn
  include Composition::Graded
  include Composition::Annotated

  extend ActiveRecord::Denormalization
  belongs_to :studier, denormalize: :student
  belongs_to :assignment, denormalize: :course

  before_save :if => :original_changed? do
    self.annotated = original
  end
end