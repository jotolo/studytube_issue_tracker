FactoryBot.define do
  factory :issue do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    manager_id {
      if rand >= 0.5
        nil
      else
        FactoryBot.create(:manager).id
      end
    }
    user_id { FactoryBot.create(:user).id }
    status { 0 }
  end
end
