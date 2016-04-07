require 'rails_helper'

RSpec.describe Classroom do
  subject { create(:classroom) }

  # Relationships
  it { is_expected.to belong_to(:course) }
  it { is_expected.to belong_to(:student) }

  # Validations
  it { is_expected.to validate_presence_of(:student) }
  it { is_expected.to validate_presence_of(:course) }
  it { is_expected.to validate_uniqueness_of(:student_id).scoped_to(:course_id) }
end
