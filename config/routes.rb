Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :transactions
  resources :sources do
    resources :transactions, only: :index
  end

  get 'monthly' => 'stats#monthly_stats'
end
