Rails.application.routes.draw do
  resources :categories, only: [:index] do
    resources :books
  end

  get 'books/random'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'categories#index'
end
