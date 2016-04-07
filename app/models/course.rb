class Course < ActiveRecord::Base
  enum status: [:active, :unactive, :blocked]

	# relationships
	has_many :classrooms, dependent: :destroy
	has_many :students, through: :classrooms

	# validations
	validates :name, presence: true, length: { maximum: 45 }
  validates :description, length: { maximum: 120 }

  # scopes
  scope :latest, -> { order(id: :desc) }
  scope :by_name, -> { order(name: :asc) }
  scope :search, -> (name) {
    where('lower(courses.name) LIKE ?', "%#{ name.downcase }%")
  }
end
