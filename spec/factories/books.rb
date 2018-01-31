FactoryBot.define do
  factory :book do
    title { FFaker::Book.title }
    author { FFaker::Book.author }
    cover { FFaker::Book.cover }
    description { FFaker::DizzleIpsum.paragraph }
    genre { FFaker::Book.genre }
    isbn { FFaker::Book.isbn }
    price { rand(0.00...40.00).round(2) }
    factory :book_with_reviews do
      transient do
        reviews_count 100
      end
      after(:create) do |book, evaluator|
        create_list(:review, evaluator.reviews_count, book: book)
      end
    end
  end
end
