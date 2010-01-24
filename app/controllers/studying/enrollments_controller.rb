class Studying::EnrollmentsController < ApplicationController
  def show
    @enrollment = Enrollment.find_by_token params[:id]
  end
end