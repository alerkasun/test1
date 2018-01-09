require 'rails_helper'

RSpec.describe EmailsController, type: :controller do
  describe 'GET confirm' do
    let(:token) { FFaker::HealthcareIpsum.characters }

    context 'confirmation token doesn\'t exists' do
      xit 'expects to get routing error' do
        expect { get :confirm, params: { token: token } }.to(
          raise_error(ActionController::RoutingError)
        )
      end
    end

    context 'confirmation token exists' do
      let(:user) { FactoryGirl.create :user }

      before do
        allow(ConfirmEmail).to(
          receive(:perform) { controller.confirm_email_success(user) }
        )
      end

      it 'should be successful' do
        get :confirm, params: { token: token }
        expect(response).to be_successful
      end

      it 'render confirm template' do
        get :confirm, params: { token: token }
        expect(response).to render_template('confirm')
      end
    end
  end
end
