class Student < ActiveRecord::Base
	include Concerns::TokenGenerator
  enum status: [:active, :unactive, :blocked]

	# relationships
	has_many :classrooms, dependent: :destroy
	has_many :courses, through: :classrooms

	# validations
	validates :name, presence: true, length: { maximum: 45 }
  validates :register_number, presence: true, length: { maximum: 45 }

  # hooks
 	before_validation :generate_register_number, on: :create

  accepts_nested_attributes_for :classrooms

  # scopes
  scope :latest, -> { order(id: :desc) }
  scope :by_name, -> { order(name: :asc) }
  scope :search, -> (name) {
    where('lower(students.name) LIKE ?', "%#{ name.downcase }%")
  }

 	private

 	def generate_register_number
 		self.register_number = generate_token(:register_number)
 	end
end
