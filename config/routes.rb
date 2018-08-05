Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :orders, only: [:index, :show] do
    collection do
      post 'import'
    end
  end

  root to: 'orders#index'
end
