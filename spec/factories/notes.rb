FactoryBot.define do
  factory :note do
    title 'title'
    body 'body'
    association :user

    trait :invalid do
      body nil
    end

  end
end
