Rails.application.routes.draw do
root 'pars#index'

get 'testpage' => 'pages#testpage'
get 'onepage' => 'pars#onepage'
post 'onepage' => 'pars#onepage'

#post 'index' => 'pars#index'
get 'index' => 'pars#index'
post 'index' => 'pars#sub'
end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
