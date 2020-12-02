Rails.application.routes.draw do
  root 'items#index'
  
  namespace :api do
    scope :v1 do
      mount_devise_token_auth_for 'User', at: 'auth'
    end
  end

  resources :items do
    put :favorite, on: :member
  end
end
