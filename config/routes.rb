Rails.application.routes.draw do
root 'main#index'


get 'update' => 'update#update'
post 'update' => 'update#update_category'

get 'index' => 'main#index'
post 'index' => 'main#sub'
get 'htts' => 'main#query'

end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
