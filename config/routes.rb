Rails.application.routes.draw do
  resources :contacts
  get 'welcome/index'

  get 'articles/blog'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


  resources :articles do
    resources :comments
  end

  root 'welcome#index'
end
