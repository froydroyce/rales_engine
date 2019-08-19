FactoryBot.define do
  factory :invoice_item do
    association :item, factory: :item
    association :invoice, factory: :invoice

    sequence(:quantity) { |n| n * 1500 }
    sequence(:unit_price) { |n| n * 1000 }
  end
end
