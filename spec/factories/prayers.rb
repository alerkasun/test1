FactoryGirl.define do
  factory :prayer do
    text { FFaker::Name.name }
    description { FFaker::Name.name }
  end
end
