Rails.application.routes.draw do
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do
    resources :product_types do
      resources :products do
        resources :option_values, controller: :product_option_values, only: :index
        resources :options, controller: :product_options
        resources :constraints, controller: :product_constraints
      end
    end

    resources :cart_items, only: %i[create index destroy]
  end
end
