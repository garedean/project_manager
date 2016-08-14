require 'rails_helper'

RSpec.describe Project, :type => :model do
  subject { Project.new(params) }

  let(:params) {
    {
      :title => 'Some Big Project'
    }
  }

  describe "validations" do
    it "is valid with valid params" do
      expect(subject).to be_valid
    end

    it "requires a title" do
      params[:title] = ''

      expect(subject).to_not be_valid
      expect(subject.errors.keys).to eq [:title]
    end

    it "requires a unique title" do
      subject.save

      expect(Project.create(params)).to_not be_valid
    end
  end

  describe "deletions" do
    it 'retains project but flags it as deleted' do
      subject.save
      subject.soft_delete

      expect(subject.deleted).to be true
    end
  end
end
