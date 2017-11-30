FactoryBot.define do
  factory :provider, parent: :user, class: Provider do
    type "Provider"
  end
end
