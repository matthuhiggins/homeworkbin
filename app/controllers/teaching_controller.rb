class TeachingController < ApplicationController
  layout 'classroom'

  def index
    @courses = current_teacher.teaching
  end
  
  def new
    @course = current_teacher.teaching.build
  end
  
  def create
    @course = current_teacher.teaching.build params[:course]
    if @course.save
      redirect_to teaching_path(@course)
    else
      render 'new'
    end
  end
  
  def show
    @course = current_teacher.teaching.find params[:id]
  end
  
  def edit
    @course = current_teacher.teaching.find params[:id]
  end
  
  def update
    @course = current_teacher.teaching.find params[:id]
    if @course.update_attributes params[:course]
      redirect_to teaching_path(@course)
    else
      render 'edit'
    end
  end
  
  def destroy
    @course = current_teacher.teaching.find params[:id]
  end
  
  private
    def current_teacher
      @current_teacher ||= current_person.becomes(Teacher)
    end
end