class Category < ApplicationRecord
  replicated_model
  has_many :books, dependent: :destroy
end
