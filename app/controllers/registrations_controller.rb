class RegistrationsController < ApplicationController
  layout 'facade'

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
    @person = @registration.build_person
  end
  
  def update
    @registration = Registration.find_by_token! params[:id]
    @person = Person.new params[:person]
    if @person.save
      Registration.delete_all :email => @registration.email
      redirect_to courses_path
    else
      render 'show'
    end
  end
end