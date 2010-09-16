require 'action_controller_test'

class Studying::EnrollmentsControllerTest < ActionController::PersonTestCase
  matches_resources 'enroll'

  test 'index' do
    enrollment = Factory.enrollment.create email: current_person.email

    person_get :index
    
    assert_equal [enrollment], assigns(:enrollments)
  end

  test 'show' do
    enrollment = Factory.enrollment.create

    get :show, id: enrollment.to_param
    
    assert_equal enrollment, assigns(:enrollment)
  end
  
  test 'update new student' do
    enrollment = Factory.enrollment.create
    
    put :update,
      :id         => enrollment.to_param, 
      enrollment: {
        :student            => Factory.student.attributes,
        :accept_enrollment  => '1'
      }
    
    assert_logged_in_as assigns(:enrollment).student
    assert_redirected_to studying_path(enrollment.course)
  end
  
  test 'update new invalid student' do
    enrollment = Factory.enrollment.create
    
    put :update,
      :id         => enrollment.to_param,
      enrollment: {
        :student            => {email: 'foo'},
        :accept_enrollment  => '1'
      }
    
    assert_template 'show'
  end
  
  test 'update existing student' do
    student = Factory.student.create
    enrollment = Factory.enrollment.create email: student.email
    
    put :update,
      :id         => enrollment.to_param,
      enrollment: {
        :accept_enrollment  => '1',
        :student            => {automatically_enroll: '1'}
      }
    
    assert_logged_in_as student
    assert_redirected_to studying_path(enrollment.course)
  end
  
  test 'destroy' do
    enrollment = Factory.enrollment.create
    
    delete :destroy, id: enrollment.to_param
    
    assert_redirected_to root_path
    assert_destroyed enrollment
  end
end