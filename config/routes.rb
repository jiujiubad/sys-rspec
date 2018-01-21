Rails.application.routes.draw do
  resources :parkings
  root "parkings#new"
end
