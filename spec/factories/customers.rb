FactoryBot.define do
  factory :customer do
    sequence(:last_name) { |n| "Last Name #{n}" }
    sequence(:first_name) { |n| "First Name #{n}" }
  end
end
