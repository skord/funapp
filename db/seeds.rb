# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#
colors = ['red','orange','yellow','olive','green','teal','blue','violet','purple','pink','brown','grey']
categories = [
  {name: "Children's", icon: 'child'},
  {name: "Mystery", icon: 'spy'},
  {name: "Medical", icon: 'doctor'},
  {name: "Textbooks", icon: 'student'},
  {name: "Star Trek", icon: 'hand spock'},
  {name: "Legal", icon: 'law'},
  {name: "Travel", icon: 'road'},
  {name: "Ecology", icon: 'leaf'},
  {name: "Booze", icon: 'cocktail'},
  {name: "Lemons", icon: 'lemon'},
  {name: "Startups", icon: 'money'},
  {name: "Sports", icon: 'soccer'},
  {name: "Geography",icon: 'world'},
  {name: "Games", icon: 'puzzle'},
  {name: "Magnets", icon: 'magnet'}
]


categories.each do |cat|
  FactoryBot.create(:category_with_books, name: cat[:name], icon: cat[:icon], color: colors.sample, books_count: 100)
end
