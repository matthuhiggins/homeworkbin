class Teaching::RegistrationsController < ApplicationController
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
    @teacher = @registration.create_teacher!
    login @teacher
  end
end