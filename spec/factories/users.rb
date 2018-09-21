FactoryBot.define do
  factory :user do
    name {Faker::StarWars.character}
    email {Faker::Internet.email(name)}
    password {Faker::Internet.password}
    confirmed_at {Date.today}

    factory :manager do
      after(:build) {|user| user.add_role(:admin)}
    end
  end
end
