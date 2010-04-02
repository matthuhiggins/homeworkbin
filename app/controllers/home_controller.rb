class HomeController < ApplicationController
  def index
    if authenticated?
      render_authenticated
    else
      render_unauthenticated
    end
  end
  
  private
    def render_authenticated
      @studying = current_person.student.studying
      @teaching = current_person.teacher.teaching
      render 'authenticated'
    end
    
    def render_unauthenticated
      render 'unauthenticated'
    end
end