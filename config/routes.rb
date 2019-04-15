Rails.application.routes.draw do
  root 'main#index'


  get 'update' => 'update#update'
  post 'update' => 'update#update_category'

  get 'index' => 'main#index'
  get 'hts' => 'main#query'
end
