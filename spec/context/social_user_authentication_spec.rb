require 'rails_helper'

RSpec.describe SocialUserAuthentication do
  let(:id) { FFaker::Guid.to_s }
  let(:email) { [FFaker::Internet.email, nil].sample }
  let(:first_name) { FFaker::Name.first_name }
  let(:last_name) { FFaker::Name.last_name }
  let(:graf_profile)
  { { id: id,
      first_name: first_name,
      last_name: last_name,
      email: email } }
  let(:providers) { %w(facebook google twitter instagram) }
  let(:provider) { providers.sample }
  let(:oauth_token) { FFaker::Guid.to_s }
  let(:oauth_secret) { FFaker::Guid.to_s }

  subject do
    SocialUserAuthentication.new(provider, oauth_token, oauth_secret)
  end

  describe '#perform' do
    before do
      allow(subject).to receive_message_chain('client.profile_info') do
        graf_profile
      end
    end

    context 'session created successfully' do
      it 'has to create a user' do
        expect { subject.perform }.to change { User.all.count }.by(1)
      end

      it 'has to create a profile' do
        expect { subject.perform }.to change { Profile.all.count }.by(1)
      end

      it 'has to create an authentication' do
        expect(subject.perform).to be_a(TokenAuth::Authentication)
      end
    end
  end
end
