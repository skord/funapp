# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#
colors = ['red','orange','yellow','olive','green','teal','blue','violet','purple','pink','brown','grey']
icons = File.read(File.join(Rails.root,'lib/icons.txt')).split("\n")
categories = Muse::CATEGORIES

if Rails.env.production?
  categories.each do |cat|
    category = Category.where(name: cat).first_or_create do |new_cat|
      new_cat.icon = icons.sample
      new_cat.color = colors.sample
    end
    muse = Muse.new(cat)
    if muse.can_complex_title?
      book_minimum = 300
      book_maximum = 500
    else
      book_minimum = 100
      book_maximum = 200
    end
    book_rand_count = rand(book_minimum..book_maximum)
    if category.books.count < book_minimum
      puts "Musing Category: #{cat}"
      muse = Muse.new(cat)
      book_rand_count.times do
        the_title = muse.title
        puts "Musing Book: #{the_title}"
        category.books.create(
          title: the_title,
          description: FFaker::DizzleIpsum.paragraph,
          author: FFaker::Book.author,
          genre: cat,
          isbn: FFaker::Book.isbn,
          price: rand(0.00...40.00).round(2)
        )
        sleep 1
      end
    end
  end

  Book.find_each do |book|
    (5...200).to_a.sample.times { FactoryBot.create(:review, book: book) }
  end
elsif Rails.env.development?
  categories.each do |cat|
    category = Category.where(name: cat).first_or_create do |new_cat|
      new_cat.icon = icons.sample
      new_cat.color = colors.sample
    end
    if category.books.count < 100
      100.times do
        FactoryBot.create(:book_with_reviews, reviews_count: 20, category: category)
      end
    end
  end
end
