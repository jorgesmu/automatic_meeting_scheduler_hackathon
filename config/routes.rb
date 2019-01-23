Rails.application.routes.draw do
  resources :invitations
  resources :attendees
  resources :meetings do
    get 'schedule', on: :member
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
