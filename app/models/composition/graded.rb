class Composition
  module Graded
    extend ActiveSupport::Concern

    included do
      scope :ungraded, where(graded_at: nil)
      scope :graded, where('graded_at is not null')
    end
  end
end