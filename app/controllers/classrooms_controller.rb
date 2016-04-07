class ClassroomsController < ApplicationController
  def index
    @classrooms = Classroom.active.latest.page(params[:page])
  end

  def create
    classroom = Classroom.new(classroom_data)
    if classroom.save
      render json: { success: true, content: render_to_string(partial: 'classrooms/classroom', locals: { classroom: classroom, deletable: true }) }
    else
      render json: { success: false, errors: classroom.errors.full_messages }
    end
  end

  def destroy
    classroom = Classroom.find(params[:id])
    if classroom.destroy
      redirect_to classrooms_path, notice: 'Student removed successfully.'
    else
      redirect_to classrooms_path, notice: student.errors.full_messages
    end
  end

  private

  def classroom_data
    {
      student: Student.find_by_name(classroom_params[:student]),
      course: Course.find_by_name(classroom_params[:course])
    }
  end

  def classroom_params
    params.permit(:student, :course)
  end
end
