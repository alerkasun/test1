FactoryGirl.define do
  factory :session do
    user

    initialize_with do
      new(user, Faker::Internet.password(64))
    end
  end
end
