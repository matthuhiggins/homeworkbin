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
      @studying = Course.scoped :include => :studiers, :conditions => {'studiers.student_id' => current_person}
      @teaching = Course.scoped :conditions => {:teacher_id => current_person}
      render 'authenticated'
    end
    
    def render_unauthenticated
      render 'unauthenticated'
    end
end