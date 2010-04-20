class Studying::EnrollmentsController < ApplicationController
  require_login only: :index
  respond_to :html, :json
  
  def index
    @enrollments = current_person.student.enrollments.includes course: :teacher
  end
  
  def show
    @enrollment = Enrollment.find_by_token! params[:id]
  end
  
  # TODO auto enrollment checkbox is ignored
  def update
    @enrollment = Enrollment.find_by_token! params[:id]
    if @enrollment.update_attributes params[:enrollment]
      when_not_from_index do
        login @enrollment.student, redirect: studying_path(@enrollment.course)
      end
    else
      render 'show'
    end
  end
  
  def destroy
    @enrollment = Enrollment.find_by_token! params[:id]
    @enrollment.destroy
    when_not_from_index do
      redirect_to root_path
    end
  end

  private
    # TODO test
    def when_not_from_index
      if request.referer == enrollments_url
        redirect_to(current_person.student.enrollments.any? ? enrollments_path : root_path)
      else
        yield
      end
    end
end
