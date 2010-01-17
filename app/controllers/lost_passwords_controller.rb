class LostPasswordsController < ApplicationController
  def new
    @lost_password = LostPassword.new params[:lost_password]
  end

  def create
    @lost_password = LostPassword.new params[:lost_password]
    if @lost_password.save
    else
    end
  end
  
  def show
    @lost_password = LostPassword.find_by_token! params[:token]
    @person = @lost_password.person
  end
  
  def update
    @lost_password = LostPassword.find_by_token! params[:token]
    @person = @lost_password.person
    
    if @person.update_attribute(:password, params[:password])
      @lost_password.destroy
    else
    end
  end
end