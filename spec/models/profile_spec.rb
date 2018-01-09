require 'rails_helper'

RSpec.describe Profile, type: :model do
  subject { FactoryGirl.create :profile }

  it { is_expected.to belong_to :profileable }

  it { is_expected.to validate_presence_of :profileable }

  describe '#edit' do
    before do
      allow(subject).to receive(:remove_avatar!)
    end

    it 'remove avatar when nil given' do
      expect(subject).to receive(:remove_avatar!)
      subject.edit! avatar: nil
    end

    it 'doesn\'t remove avatar when it\'s not specified in params' do
      expect(subject).not_to receive(:remove_avatar!)
      subject.edit! params
    end

    it 'update profile' do
      expect(subject).to receive(:update!)
      subject.edit! params
    end

    def params
      { first_name: FFaker::Name.first_name,
        last_name: FFaker::Name.last_name }
    end
  end
end
