class Composition
  module HandIn
    def self.included base
      base.class_eval do
        attr_accessor :hand_in

        base.before_save :if => :hand_in do |composition|
          composition.handed_in_at = Time.current
        end
      end
    end
    
    def handed_in?
      handed_in_at.present?
    end
  end
end