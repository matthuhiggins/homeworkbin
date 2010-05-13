class Composition
  module Annotated
    extend ActiveSupport::Concern

    included do
      has_many :annotations, :dependent => :delete_all#, :autosave => true
    end

    def annotations_attributes=(attributes_collection)
      self.annotations = attributes_collection.map do |attributes|
        Annotation.new(attributes)
      end
    end
  end
end