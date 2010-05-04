class Composition
  module HandIn
    extend ActiveSupport::Concern

    included do
      attr_accessor :hand_in

      before_save if: :hand_in do
        self.handed_in_at = Time.current
      end

      scope :handed_in, where('handed_in_at is not null')
    end

    def hand_in!
      touch :handed_in_at
    end

    def handed_in?
      handed_in_at.present?
    end
    
    def late_hand_in?
      if handed_in?
        assignment.late_submission? self
      else
        Time.current.change(sec: 0) > assignment.due_at
      end
    end
  end
end