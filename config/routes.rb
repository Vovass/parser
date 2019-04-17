Rails.application.routes.draw do
  root 'main#index'

  get 'index' => 'main#index'
  get 'hts' => 'main#query'
end
