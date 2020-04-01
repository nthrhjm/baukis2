Rails.application.routes.draw do
  namespace :staff do
    root 'top#index'
    get "login" => "sessions#new", as: :login
    post "session" => "sessions#create", as: :sesion
    delete "session" => "sessions#destroy"
  end

  namespace :admin do
    root 'top#index'
  end

  namespace :customer do
    root 'top#index'
  end
end
