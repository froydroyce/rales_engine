FactoryBot.define do
  factory :invoiceitem do
    quantity { 1 }
    unit_price { 1.5 }
    invoice { nil }
    item { nil }
  end
end
