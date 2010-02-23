class Teaching::RegistrationsController < ApplicationController
  layout 'playground'

  def create
    @registration = Registration.new params[:registration]
    if @registration.save
      render 'thanks'
    else
      render 'index'
    end
  end

  def index
    @registration = Registration.new
  end

  def show
    @registration = Registration.find_by_token! params[:id]
    @teacher = @registration.create_teacher!
    login @teacher
  end
end