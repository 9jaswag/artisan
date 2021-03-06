Rails.application.routes.draw do
  scope :quotes do
    get "new/:type", to: 'quotes#new', as: 'new_quote'
    post 'create', to: 'quotes#create', as: 'create_quote'
    get ':id', to: 'quotes#show', as: 'show_quote'
  end

  get 'dashboard', to: 'dashboard#index'

  devise_for :users

  devise_scope :user do
    root to: "devise/sessions#new"
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
