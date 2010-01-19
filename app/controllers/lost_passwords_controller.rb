class LostPasswordsController < ApplicationController
  layout 'playground'

  def new
    @lost_password = LostPassword.new params[:lost_password]
  end

  def create
    @lost_password = LostPassword.new params[:lost_password]
    if @lost_password.save
      render 'confirm'
    else
      render 'new'
    end
  end
  
  def show
    @lost_password = LostPassword.find_by_token! params[:id]
    @person = @lost_password.person
  end
  
  def update
    @lost_password = LostPassword.find_by_token! params[:id]
    @person = @lost_password.person
    
    if @lost_password.update_attributes params[:lost_password]
      login @lost_password.person
    else
      render 'show'
    end
  end
end