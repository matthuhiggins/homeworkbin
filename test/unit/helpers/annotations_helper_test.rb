require 'action_view_test'

class AnnotationsHelperTest < ActionView::TestCase
  test 'annotations_to_json' do
    annotation = Factory.annotation.create

    output = annotations_to_json([annotation])
    
    assert output.html_safe?
    assert_equal "[#{annotation.to_json(only: [:identifier, :comment, :snippet])}]", output
  end
end