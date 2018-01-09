FactoryGirl.define do
  factory :profile do
    association :profileable, factory: :user
    avatar File.open(File.join(Rails.root, '/spec/fixtures/files/image_1.jpg'))

    first_name { FFaker::Name.name }
    last_name { FFaker::Name.name }
  end
end
