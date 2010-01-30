class Studying::EnrollmentsController < ApplicationController
  def show
    @enrollment = Enrollment.find_by_token! params[:id]
  end
  
  def update
    @enrollment = Enrollment.find_by_token! params[:id]
    if @enrollment.update_attributes params[:enrollment]
      login @enrollment.student
    else
      render 'show'
    end
  end
end
