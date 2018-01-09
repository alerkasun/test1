require 'rails_helper'

RSpec.describe Api::V1::SessionsController, type: :controller do
  describe 'POST #create' do
    let(:password) { FFaker::Internet.password }
    let(:email) { FFaker::Internet.safe_email }
    let(:user) { FactoryGirl.create :user, password: password, email: email }

    def create_session
      user
      post :create, params: { email: email, password: password }
    end

    def response_body
      JSON.parse(response.body)
    end

    context 'Authenticate user' do
      let(:session) do
        instance_double(
          TokenAuth::Authentication,
          entity: user,
          auth_token: SecureRandom.hex
        )
      end

      before do
        allow(User).to receive(:authenticate) { session }
      end

      it 'authenticate user' do
        expect(User).to receive(:authenticate)
        create_session
      end
    end

    it 'has to be success' do
      create_session
      expect(response).to be_successful
    end

    it 'has to have user field and token' do
      create_session
      expect(response_body['data'].keys).to(
        include('user', 'authentication_token')
      )
    end
  end
end
