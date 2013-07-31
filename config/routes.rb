Cfrp::Application.routes.draw do
  devise_for :users, :path_names => { :sign_out => 'logout' }

  path_prefix = Cfrp::Application.config.path_prefix

  scope "(/#{path_prefix})" do
    faceting_for :registers  # NB must be BEFORE any resources!
  end

  resources :registers
  resources :plays

  root to: "admin/registres#index"

  # devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
end
