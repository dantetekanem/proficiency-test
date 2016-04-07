require 'rails_helper'

RSpec.describe Student do
  subject { create(:student, :active) }
  before { allow(subject).to receive(:active?).and_return(true) }

  # Relationships
  it { is_expected.to have_many(:classrooms).dependent(:destroy) }
  it { is_expected.to have_many(:courses).through(:classrooms) }

  # Validations
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:register_number) }
  it { is_expected.to ensure_length_of(:name).is_at_most(45) }
  it { is_expected.to ensure_length_of(:register_number).is_at_most(45) }

  # Callbacks
  it { is_expected.to callback(:generate_register_number).before(:validation) }

  context 'Sign up to course' do
    let!(:student) { create(:student, :active) }
    let(:course) { create(:course, :active) }

    before do
      student.courses << course
      student.save
    end
    it { expect(student.courses.size).to eql(1) }
    it { expect(student.classrooms.size).to eql(1) }
  end
end
