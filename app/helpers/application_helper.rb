module ApplicationHelper
  def student_status
    Student.statuses.keys.to_a.map { |s| [s.humanize, s] }
  end

  def course_status
    Course.statuses.keys.to_a.map { |s| [s.humanize, s] }
  end
end
