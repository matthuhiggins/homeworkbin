class Composition
  module Graded
    extend ActiveSupport::Concern

    included do
      scope :ungraded, where(graded_at: nil)
      scope :graded, where('graded_at is not null')
      scope :grade_unreviewed, graded.where(grade_reviewed_at: nil)
    end

    def graded?
      graded_at.present?
    end
  end
end