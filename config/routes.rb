Rails.application.routes.draw do
  resources :invitations
  resources :attendees
  resources :meetings
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
