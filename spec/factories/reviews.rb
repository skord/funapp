FactoryBot.define do
  factory :review do
    reviewer_name { FFaker::Name.html_safe_name }
    rating {(1..5).to_a.sample}
    review { FFaker::HipsterIpsum.paragraph }
    book nil
  end
end
