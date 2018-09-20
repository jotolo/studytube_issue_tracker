FactoryBot.define do
  factory :user do
    name {Faker::StarWars.character}
    email {Faker::Internet.email(name)}
    password {Faker::Internet.password}
    confirmed_at {Date.today}
  end
end
