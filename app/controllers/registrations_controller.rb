class RegistrationsController < ApplicationController
  layout 'marketing'

  def create
    @registration = Registration.new params[:registration]
    if @registration.save
      redirect_to :action => 'thanks'
      flash[:message] = "Thanks for signing up!"
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
      @registration.delete_all :conditions => {:email => email}
      redirect_to courses_path
    end
  end
end