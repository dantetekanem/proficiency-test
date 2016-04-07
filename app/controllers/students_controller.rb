class StudentsController < ApplicationController
  before_filter :load_active_courses, only: [:new, :edit]

  def index
    @students = Student.latest.page(params[:page])
  end

  def search
    students = Student.search(params[:phrase]).by_name.limit(10)
    render json: students
  end

  def new
    @student = Student.new
  end

  def create
    student = Student.new(student_params)
    if student.save
      redirect_to new_student_path, notice: 'Student created successfully.'
    else
      redirect_to new_student_path, alert: student.errors.full_messages
    end
  end

  def edit
    @student = Student.find(params[:id])
  end

  def update
    student = Student.find(params[:id])
    if student.update(student_params)
      redirect_to edit_student_path(student), notice: 'Student updated successfully.'
    else
      redirect_to edit_student_path(student), alert: student.errors.full_messages
    end
  end

  def destroy
    student = Student.find(params[:id])
    if student.destroy
      redirect_to students_path, notice: 'Student removed successfully.'
    else
      redirect_to students_path, notice: student.errors.full_messages
    end
  end

  private

  def student_params
    params.require(:student).permit(:name, :status, course_ids: [])
  end

  def load_active_courses
    @courses = Course.active
  end
end
