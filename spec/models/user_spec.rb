require 'rails_helper'

RSpec.describe User, type: :model do
  subject { FactoryGirl.create :user }

  it { is_expected.to validate_uniqueness_of :email }

  describe '.create_with_profile!' do
    it { expect(User).to respond_to :create_with_profile! }

    it 'return user object' do
      expect(User.create_with_profile!(params)).to be_a(User)
    end

    it 'change users counter' do
      expect { User.create_with_profile!(params) }.to(
        change { User.count }.by(1)
      )
    end

    context 'Bad arguments' do
      it 'raise an exception ArgumentError' do
        expect { User.create_with_profile! }.to raise_error(ArgumentError)
      end
    end

    def params
      {
        email: FFaker::Internet.safe_email,
        password: FFaker::Internet.password
      }
    end
  end

  describe 'Delegations' do
    [:first_name, :last_name, :avatar].each do |method|
      it { is_expected.to delegate_method(method).to(:profile) }
    end
  end
end
