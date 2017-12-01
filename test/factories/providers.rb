FactoryBot.define do
  factory :provider, parent: :user, class: Provider do
    type "Provider"
    iva { "21%" }
    category { Category.all.first[0] }
  end
end
