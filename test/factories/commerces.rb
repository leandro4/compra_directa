FactoryBot.define do
  factory :commerce, parent: :user, class: Commerce do
    type "Commerce"
  end
end
