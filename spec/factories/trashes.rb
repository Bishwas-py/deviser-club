FactoryBot.define do
  factory :trash do
    trashable_id { 1 }
    trashable_type { "MyString" }
    user_id { 1 }
  end
end
