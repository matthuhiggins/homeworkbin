class Studying::EnrollmentsController < ApplicationController
  require_login :only => :index
  
  def index
    @enrollments = current_person.student.enrollments(:include => {:course => :teacher})
  end
  
  def show
    @enrollment = Enrollment.find_by_token! params[:id]
  end
  
  # TODO auto enrollment checkbox is ignored
  def update
    @enrollment = Enrollment.find_by_token! params[:id]
    if @enrollment.update_attributes params[:enrollment]
      login @enrollment.student, :redirect => studying_path(@enrollment.course)
    else
      render 'show'
    end
  end
  
  def destroy
    @enrollment = Enrollment.find_by_token! params[:id]
    @enrollment.destroy
    redirect_to root_path
  end
end
