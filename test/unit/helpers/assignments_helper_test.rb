require 'action_view_test'

class AssignmentsHelperTest < ActionView::TestCase
  def test_new_assignment_form
    assignment_form build_assignment do |f|
    end
    
    assert_equal(
      content_tag(:form, '', {
        :class  => 'new_assignment',
        :action => teaching_assignments_path(current_course),
        :id     => 'assignment-form',
        :method => 'post'
      }),
      output_buffer
    )
  end
  
  def test_edit_assignment_form
    assignment = create_assignment
    
    assignment_form assignment do |f|
    end
    
    assert_equal(
      content_tag(
        :form,
        '<div style="margin:0;padding:0;display:inline"><input name="_method" type="hidden" value="put" /></div>',
        :class  => 'edit_assignment',
        :action => teaching_assignment_path(current_course, assignment),
        :id     => 'assignment-form',
        :method => 'post'
      ),
      output_buffer
    )
  end
  
  def test_default_due_date
    assert_equal '12/25/2005', default_assignment_due_date(build_assignment :due_date => '12/25/2005')
    assert_equal Date.current.strftime('%m/%d/%Y'), default_assignment_due_date(current_course.assignments.new)
  end
  
  def test_assignment_due_minute_options
    options = assignment_due_minute_options
    
    assert_equal 48, options.size
    assert options.include?(['11:00am', 660])
    assert options.include?(['2:30pm', 870])
  end
  
  def test_default_due_minutes_without_last
    assert 120, default_assignment_due_minutes(build_assignment :due_minutes => 120)
    assert_equal 12 * 60, default_assignment_due_minutes(build_assignment :due_minutes => nil)
  end

  def test_default_due_minutes_defaults_to_last
    create_assignment :due_minutes => 120
    
    assignment = current_course.assignments.new
    
    assert_equal 120, default_assignment_due_minutes(assignment)
  end
  
  def test_default_handout
    assert default_assignment_handout(build_assignment :handout => '1')
    assert default_assignment_handout(build_assignment :handout => nil)
    assert !default_assignment_handout(build_assignment :handout => '0')
  end
  
  def test_save_assignment_text
    assert_equal 'Assign homework »', save_assignment_text(Factory.build :course)
    assert_equal 'Update assignment', save_assignment_text(Factory :course)
    
  end
  
  def test_assignment_due_at
    assignment = build_assignment

    assert_equal assignment.due_date.strftime('%a, %b %d'), assignment_due_at(assignment)
  end
  
  def test_relative_due_date
    assert_equal 'Today', relative_assignment_due_date(Assignment.new :due_date => Date.current)
    assert_equal 'Tomorrow', relative_assignment_due_date(Assignment.new :due_date => Date.current.tomorrow)
    assert_equal 'Thu, Dec 25', relative_assignment_due_date(Assignment.new :due_date => Date.new(2003, 12, 25))
  end
  
  private
    def build_assignment(attributes = {})
      Factory.build :assignment, attributes.reverse_merge!(:course => current_course)
    end
    
    def create_assignment(attributes = {})
      Factory :assignment, attributes.reverse_merge!(:course => current_course)      
    end
end