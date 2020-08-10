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
  end

end
