require 'rails_helper'

RSpec.describe PasswordsController, type: :controller do
  let(:token) { SecureRandom.hex }

  describe 'GET #edit' do
    context 'with not valid token' do
      it 'returns http status not found' do
        get :edit, params: { token: token }
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'with valid token' do
      let(:user) { FactoryGirl.create :user }

      before do
        recovery_token = instance_double(TokenAuth::PasswordRecoveryToken,
                                         entity: user, destroy: nil,
                                         token: SecureRandom.hex)

        allow(controller).to receive(:recoverable_token) { recovery_token }
      end

      it 'returns http success' do
        get :edit, params: { token: token }
        expect(response).to have_http_status(:success)
      end

      it 'has to render edit view' do
        get :edit, params: { token: token }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'PUT #update' do
    let(:user) { FactoryGirl.create :user }
    let(:password) { FFaker::Internet.password }

    let(:params) do
      {
        token: token,
        reset_password_form: {
          password: password,
          password_confirmation: password
        }
      }
    end

    before do
      recovery_token = instance_double(TokenAuth::PasswordRecoveryToken,
                                       entity: user, destroy: nil,
                                       token: SecureRandom.hex)

      allow(controller).to receive(:recoverable_token) { recovery_token }
    end

    it 'has to render index view' do
      put :update, params: params
      expect(response).to render_template(:index)
    end

    it 'response has to be successful' do
      put :update, params: params
      expect(response).to have_http_status(:success)
    end

    context 'form validations failed' do
      let(:params) do
        {
          token: token,
          reset_password_form: {
            password: password,
            password_confirmation: ''
          }
        }
      end

      it 'has to render edit view' do
        put :update, params: params
        expect(response).to render_template(:edit)
      end
    end
  end
end
