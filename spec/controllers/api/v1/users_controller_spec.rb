require 'rails_helper'

describe Api::V1::UsersController do
  describe 'POST #create' do
    it 'has to be success' do
      post :create, params: { email: FFaker::Internet.email,
                              password: FFaker::Internet.password }

      expect(response).to be_successful
    end

    context 'email has been taken' do
      let(:user) { FactoryGirl.create :user }

      it 'should has 422 status code' do
        skip
        # TODO: need to add 422
        post :create, params: { email: user.email, password: user.password }
        expect(response.status).to eq(422)
      end
    end
  end
end
