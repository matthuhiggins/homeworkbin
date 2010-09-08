module AnnotationsHelper
  def annotations_to_json(annotations)
    annotations.to_json(only: [:identifier, :comment, :snippet]).html_safe
  end
end