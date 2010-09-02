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
      @studying = current_person.student.studying.current.all
      @enrollment_count = current_person.student.enrollments.count
      @teaching = current_person.teacher.teaching.current.all
      render 'authenticated'
    end
    
    def render_unauthenticated
      render 'unauthenticated'
    end
end