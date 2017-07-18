Rails.application.routes.draw do
  root to: 'application#root'
  resources :match_data
end
