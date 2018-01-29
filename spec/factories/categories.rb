FactoryBot.define do
  factory :category do
    name { FFaker::Skill.specialty }
    factory :category_with_books do
      transient do
        books_count 50
      end
      after(:create) do |category, evaluator|
        create_list(:book, evaluator.books_count, category: category)
      end
    end
  end
end
