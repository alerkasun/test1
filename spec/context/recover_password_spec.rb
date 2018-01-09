require 'rails_helper'

RSpec.describe RecoverPassword do
  let(:user) { FactoryGirl.create :user }
  let(:controller) { ActionController::Base.new }

  describe '#perform' do
    before do
      allow(subject).to receive(:generate_link) { 'valid_link' }
    end

    context 'when recover successful' do
      subject { RecoverPassword.new(user, controller) }

      before do
        allow(subject).to(
          receive_message_chain('controller.recover_password_success')
        )
      end

      it 'has to hit listener success method' do
        expect(subject.controller).to receive(:recover_password_success)
        subject.perform
      end

      it 'has to send token email' do
        expect(subject).to receive(:send_mail)
        subject.perform
      end
    end

    context 'when recover fails' do
      subject { RecoverPassword.new(nil, controller) }

      before do
        allow(subject).to(
          receive_message_chain('controller.recover_password_error')
        )
      end

      it 'has to hit listener error method' do
        expect(subject.controller).to receive(:recover_password_error)
        subject.perform
      end
    end
  end
end
