class CoursesController < ApplicationController
  before_filter :load_active_students, only: [:new, :edit]

  def index
    @courses = Course.latest.page(params[:page])
  end

  def search
    courses = Course.search(params[:phrase]).by_name.limit(10)
    render json: courses
  end

  def new
    @course = Course.new
  end

  def create
    course = Course.new(course_params)
    if course.save
      redirect_to new_course_path, notice: 'Course created successfully.'
    else
      redirect_to new_course_path, alert: course.errors.full_messages
    end
  end

  def edit
    @course = Course.find(params[:id])
  end

  def update
    course = Course.find(params[:id])
    if course.update(course_params)
      redirect_to edit_course_path(course), notice: 'Course updated successfully.'
    else
      redirect_to edit_course_path(course), alert: course.errors.full_messages
    end
  end

  def destroy
    course = Course.find(params[:id])
    if course.destroy
      redirect_to courses_path, notice: 'Course removed successfully.'
    else
      redirect_to courses_path, notice: course.errors.full_messages
    end
  end

  private

  def course_params
    params.require(:course).permit(:name, :description, :status, student_ids: [])
  end

  def load_active_students
    @students = Student.active
  end
end
