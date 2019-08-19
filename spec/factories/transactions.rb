FactoryBot.define do
  factory :transaction do
    association :invoice, factory: :invoice

    sequence :credit_card_number { |n| (4654405418249632 + n).to_s }
    result { "success" }
  end
end
