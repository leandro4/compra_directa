FactoryBot.define do
  factory :question do
    commerce
    product
    question { FFaker::Lorem.sentence }
    answer { FFaker::Lorem.sentence }
    answered_at { 1.hour.ago }
  end
end
