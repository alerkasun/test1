require 'rails_helper'

RSpec.describe ResetPassword do
  let(:user) { FactoryGirl.create :user }
  let(:controller) { ActionController::Base.new }
  let(:password) { FFaker::Internet.password }

  let(:password_recovery_token) do
    instance_double(
      TokenAuth::PasswordRecoveryToken,
      entity: user,
      destroy: nil
    )
  end

  describe '#perform' do
    context 'when reset successful' do
      subject do
        ResetPassword.new(password_recovery_token, password, controller)
      end

      before do
        allow(subject).to(
          receive_message_chain('listener.reset_password_on_success')
        )
      end

      it 'has to hit listener success method' do
        expect(subject.listener).to receive(:reset_password_on_success)
        subject.perform
      end

      it 'has to ensure password changed' do
        expect { subject.perform }.to(
          change { subject.recoverable.entity.password }
        )
      end
    end

    context 'when reset fails' do
      subject { ResetPassword.new(password_recovery_token, nil, controller) }

      before do
        allow(subject).to(
          receive_message_chain('listener.reset_password_on_error')
        )
        allow(subject).to receive(:entity) { RuntimeError.new }
      end

      it 'has to hit listener error method' do
        expect(subject.listener).to receive(:reset_password_on_error)
        subject.perform
      end
    end
  end
end
