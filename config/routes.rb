Rails.application.routes.draw do
  root "static_pages#index"
  get 'static_pages/about'
  get 'static_pages/help'
  devise_for :users
  resources :rooms, only: [:show, :index, :create, :new]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # setting for letter_opener_web gem
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
