Cfrp::Application.routes.draw do
  devise_for :users, :path_names => { :sign_out => 'logout' }

  faceting_for :plays

  resources :registers
  # resources :plays

  resources :plays do
    collection { post :import }
  end

  resources :people do
    collection { post :import }
  end

  resources :play_ticket_sales, only: [:index]

  root to: "admin/registers#index"

  # devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
end
