Rails.application.routes.draw do
root 'pars#index'


get 'update' => 'pages#update'
post 'update' => 'pages#update_category'

get 'index' => 'pars#index'
post 'index' => 'pars#sub'
end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
