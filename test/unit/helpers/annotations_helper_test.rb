require 'action_view_test'

class AnnotationsHelperTest < ActionView::TestCase
  def test_annotations_to_json
    annotation = Factory.annotation.create

    output = annotations_to_json([annotation])
    
    assert output.html_safe?
    assert_equal "[#{annotation.to_json(only: [:identifier, :comment, :snippet])}]", output
  end
end