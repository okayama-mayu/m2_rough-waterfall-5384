Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    resources :customers, only: [:show]
    
    resources :supermarkets, only: [:show] do 
      resources :items, only: [:index], :controller => 'supermarket_items' 
    end
end
