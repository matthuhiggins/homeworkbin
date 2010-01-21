class RegistrationsController < ApplicationController
  layout 'playground'

  def create
    @registration = Registration.new params[:registration]
    if @registration.save
      redirect_to :action => 'thanks'
    else
      render 'new'
    end
  end
  
  def new
    @registration = Registration.new
  end

  def show
    @registration = Registration.find_by_token! params[:id]
    @teacher = @registration.build_teacher
  end
  
  def update
    @registration = Registration.find_by_token! params[:id]
    @teacher = Teacher.new params[:teacher]
    if @teacher.save
      Registration.delete_all :email => @registration.email
      login @teacher
    else
      render 'show'
    end
  end
end