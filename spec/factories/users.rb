FactoryGirl.define do
  factory :user do
    email { FFaker::Internet.safe_email }
    password { FFaker::Internet.password }

    after :create do |user|
      user.profile = build(:profile, profileable: user)
    end
  end
end
