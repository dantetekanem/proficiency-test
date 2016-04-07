class HomeController < ApplicationController
  def index
    @students = Student.active
    @courses = Course.active
    @classrooms = Classroom.active
  end
end
