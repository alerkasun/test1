require 'rails_helper'

RSpec.describe ConfirmEmail do
  subject do
    ConfirmEmail.new(
      FFaker::HealthcareIpsum.characters, ActionController::Base.new
    )
  end

  let(:user) { FactoryGirl.create :user }

  let(:token) { FFaker::HealthcareIpsum.characters }

  let(:confirmation_token) do
    instance_double(TokenAuth::ConfirmationToken, entity: user, destroy: nil)
  end

  context 'Successful confirmation' do
    before do
      allow(subject).to receive(:entity) { user }

      allow(subject).to(
        receive_message_chain('entities.choose_confirmable') { user }
      )
      allow(subject).to receive_message_chain('listener.confirm_email_success')
      allow(subject).to receive_message_chain('listener.confirm_email_error')

      allow(subject).to receive(:find_token) { confirmation_token }
    end

    it 'email should be marker as confirmed' do
      expect { subject.perform }.to(
        change { subject.entity.email_confirmed }.from(false).to(true)
      )
    end

    it 'has hit success listener method' do
      expect(
        subject.listener
      ).to receive(:confirm_email_success).with(kind_of(User))
      subject.perform
    end

    it 'has to ensure changes were saved' do
      expect(subject.entity).to receive(:update!)
      subject.perform
    end
  end
end
