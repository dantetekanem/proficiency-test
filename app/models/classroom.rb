class Classroom < ActiveRecord::Base
	# relationships
  belongs_to :student
  belongs_to :course

  # validations
  validates :student, presence: true
  validates :course, presence: true
  validates :student_id, uniqueness: { scope: :course_id }

  # hooks
  before_create :generate_entry_at

  # scopes
  scope :active_student, -> {
    joins(:student).where(students: { status: 'active' })
  }
  scope :active_course, -> {
    joins(:course).where(courses: { status: 'active' })
  }
  scope :active, -> {
    active_student.active_course
  }
  scope :latest, -> {
    order(id: :desc)
  }

  private

  def generate_entry_at
  	self.entry_at = Time.zone.now
  end
end
