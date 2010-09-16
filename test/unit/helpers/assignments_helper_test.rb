require 'action_view_test'

class AssignmentsHelperTest < ActionView::TestCase
  test 'default_due_date' do
    assert_equal '12/25/2005', default_assignment_due_date(build_assignment due_date: '12/25/2005')
    assert_equal Date.current.strftime('%m/%d/%Y'), default_assignment_due_date(current_course.assignments.new)
  end
  
  test 'assignment_due_minute_options' do
    options = assignment_due_minute_options
    
    assert_equal 48, options.size
    assert options.include?(['11:00am', 660])
    assert options.include?(['2:30pm', 870])
  end
  
  test 'default_due_minutes_without_last' do
    assert_equal 120, default_assignment_due_minutes(build_assignment due_minutes: 120)
    assert_equal 12 * 60, default_assignment_due_minutes(build_assignment due_minutes: nil)
  end

  test 'default_due_minutes_defaults_to_last' do
    create_assignment due_minutes: 120
    
    assignment = current_course.assignments.new
    
    assert_equal 120, default_assignment_due_minutes(assignment)
  end
  
  test 'default_handout' do
    assert default_assignment_handout(build_assignment handout: '1')
    assert default_assignment_handout(build_assignment handout: nil)
    assert !default_assignment_handout(build_assignment handout: '0')
  end
  
  test 'save_assignment_text' do
    assert_equal 'Assign homework', save_assignment_text(Factory.course.build)
    assert_equal 'Update assignment', save_assignment_text(Factory.course.create)
    
  end
  
  test 'assignment_due_at' do
    assignment = build_assignment

    assert_equal assignment.due_date.strftime('%a, %b %d'), assignment_due_at(assignment)
  end
  
  private
    def build_assignment(attributes = {})
      Factory.assignment.build attributes.reverse_merge!(course: current_course)
    end
    
    def create_assignment(attributes = {})
      Factory.assignment.create attributes.reverse_merge!(course: current_course)      
    end
end