Rails.application.routes.draw do
  root to: "home#index"

  resource :profile, only: [:show, :update]

  namespace :sessions do
    get "/sign_out", to: "sessions#destroy"

    resource :sign_up, only: [] do
      get "/", to: "sign_up#new"
      post "/", to: "sign_up#create"
    end

    resource :sign_in, only: [] do
      get "/", to: "sign_in#new"
      post "/", to: "sign_in#create"
    end

    resource :reset_token, only: [] do
      get "/", to: "reset_token#new"
      post "/", to: "reset_token#create"
    end

    resources :reset_password, only: [] do
      get "/", to: "reset_passwords#show"
      post "/", to: "reset_passwords#update"
    end
  end

end
