require 'rails_helper'

RSpec.describe AvatarUploader do
  include CarrierWave::Test::Matchers

  let(:user) { FactoryGirl.create :user }

  before do
    AvatarUploader.enable_processing = true
    @uploader = AvatarUploader.new(user, :avatar)

    File.open(File.join(Rails.root, '/spec/fixtures/files/image_1.jpg')) do |f|
      @uploader.store!(f)
    end
  end

  after do
    AvatarUploader.enable_processing = false
    @uploader.remove!
  end

  context 'the small version' do
    it 'should scale down a landscape image to fit within 100 by 300 pixels' do
      expect(@uploader.thumb_min).to be_no_larger_than(100, 300)
    end

    it 'should scale down a landscape image to fit within 250 by 400 pixels' do
      expect(@uploader.thumb_min).to be_no_larger_than(250, 400)
    end

    it 'should scale down a landscape image to fit within 400 by 600 pixels' do
      expect(@uploader.thumb_min).to be_no_larger_than(400, 600)
    end
  end

  it 'should make the image readable only to the owner and not executable' do
    expect(@uploader).to have_permissions(0o644)
  end
end
