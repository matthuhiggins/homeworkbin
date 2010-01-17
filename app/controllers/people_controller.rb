class PeopleController < ApplicationController
  layout 'playground'
  
  def new
    @registration = Registration.find_by_token! params[:token]
    @teacher = @registration.build_teacher
  end
  
  def create
    @registration = Registration.find_by_token! params[:token]
    @teacher = Teacher.new params[:teacher]
    
    if @teacher.save
      
    else
    end
  end
end