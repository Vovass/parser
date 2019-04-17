Rails.application.routes.draw do
  root 'main#index'

  get 'index' => 'main#index'
  get 'check' => 'main#check'

  get 'updateProduct' => 'main#updateProducts'


end
