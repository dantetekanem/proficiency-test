require 'rails_helper'

RSpec.describe Course do
  subject { create(:course, :active) }
  before { allow(subject).to receive(:active?).and_return(true) }

  # Relationships
  it { is_expected.to have_many(:classrooms).dependent(:destroy) }
  it { is_expected.to have_many(:students).through(:classrooms) }

  # Validations
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to ensure_length_of(:name).is_at_most(45) }
  it { is_expected.to ensure_length_of(:description).is_at_most(120) }

  context 'Sign up to student' do
    let!(:course) { create(:course, :active) }
    let(:student) { create(:student, :active) }

    before do
      course.students << student
      course.save
    end
    it { expect(course.students.size).to eql(1) }
    it { expect(course.classrooms.size).to eql(1) }
  end
end
