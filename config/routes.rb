Rails.application.routes.draw do
  devise_for :users

  root "units#index"

  resources :units, only: [:index, :show, :update] do
    resources :rooms, only: [:show, :update], shallow: true
  end

  get  'preview'        => 'preview#index',  as: :preview
  post 'preview/deploy' => 'preview#deploy', as: :deploy
end
