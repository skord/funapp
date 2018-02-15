Rails.application.routes.draw do
  get 'reviews/index'

  resources :categories, only: [:index] do
    resources :books
  end

  resources :books do
    resources :reviews, only: [:index, :new, :create]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'categories#index'
end
