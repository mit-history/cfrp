Cfrp::Application.routes.draw do
  devise_for :users, :path_names => { :sign_out => 'logout' }

  resources :registers
  
  # resources :plays
  # to allow import from csv
  # per: http://railscasts.com/episodes/396-importing-csv-and-excel
  resources :plays do
    collection { post :import }
  end

  root to: "admin/registers#index"

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
end
