require 'rails_helper'

RSpec.describe Prayer, type: :model do
  subject { FactoryGirl.create :prayer }

  it { is_expected.to validate_presence_of :text }

  describe Prayer do
    it { should have_many(:lists) }
    it { should have_many(:groups) }
  end

  def params
    {
      email: FFaker::Internet.safe_email,
      password: FFaker::Internet.password
    }
  end
end
