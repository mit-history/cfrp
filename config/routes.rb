Cfrp::Application.routes.draw do
  devise_for :users, :path_names => { :sign_out => 'logout' }

  faceting_for :plays
  faceting_for :registers
  faceting_for :people

  resources :registers

  resources :plays do
    collection { post :import }
  end

  resources :people do
    collection { post :import }
  end

  resources :play_ticket_sales, only: [:index]

  resources :play_performances, only: [:index]

  get '/api/cfrp/dimension', controller: 'analytics', action: 'dimensions'
  get '/api/cfrp/aggregate', controller: 'analytics', action: 'aggregates'
  get '/api/cfrp/aggregate/:agg', controller: 'analytics', action: 'aggregate'
  get '/api/cfrp/dimension/:dim', controller: 'analytics', action: 'dimension'

  # TODO.  should move to JSON property via registers url
  get '/api/cfrp/image', controller: 'analytics', action: 'image_url'

  root to: "admin/registers#index"

  # devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
end
