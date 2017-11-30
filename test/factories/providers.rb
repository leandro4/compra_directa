FactoryBot.define do
  factory :provider, parent: :user, class: Provider do
    type "Provider"
    category { Category.all.first[0] }
  end
end
