Rails.application.routes.draw do
  root 'robots#index'
  resources :robots
end
