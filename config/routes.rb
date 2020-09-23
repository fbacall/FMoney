Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :transactions do
    collection do
      get :import
      post :parse_paste
      post :parse_csv
      post :bulk_create
    end
  end

  resources :sources do
    resources :transactions, only: :index
  end

  resources :stats, only: [] do
    collection do
      get :monthly
    end
  end
end
