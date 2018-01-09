require 'rails_helper'

RSpec.describe CreateUser do
  let(:controller) { ActionController::Base.new }
  let(:user) { FactoryGirl.create :user }

  subject do
    user_params = { email: FFaker::Internet.email,
                    password: FFaker::Internet.password }
    CreateUser.new user_params, controller
  end

  describe '#perform' do
    before do
      allow(subject).to(
        receive_message_chain('listener.confirm_email_by_token_url') do
          FFaker::Internet.http_url
        end
      )
      allow(subject).to receive_message_chain('listener.on_create_user_success')
      allow(subject).to receive_message_chain('listener.on_create_user_error')
    end

    context 'user created successfully' do
      before do
        allow(User).to(
          receive(:create_with_profile!) do
            user.extend CreateUser::RegistrationActions
          end
        )
      end

      it 'has to create user' do
        expect { subject.perform }.to change { User.all.count }.by(1)
      end

      it 'has to create profile' do
        expect { subject.perform }.to change { Profile.all.count }.by(1)
      end

      it 'has hit success listener method' do
        expect(subject.listener).to receive(:on_create_user_success)
        subject.perform
      end
    end

    context 'user create failed' do
      before do
        allow(subject).to(
          receive_message_chain('user.send_confirmation_email') do
            raise RuntimeError.new
          end
        )
      end

      it 'has hit error listener method' do
        expect(subject.listener).to receive(:on_create_user_error)
        subject.perform
      end
    end
  end
end
