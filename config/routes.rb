require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users

  root "units#index"

  resources :units, only: [:index, :show, :update] do
    resources :rooms, only: [:show, :update], shallow: true do
      resources :photos, only: [:create]
    end
  end

  get  'preview'        => 'preview#index',  as: :preview
  post 'preview/deploy' => 'preview#deploy', as: :deploy

  authenticate :user, lambda { |u| u.deployer? } do
    mount Sidekiq::Web => '/sidekiq', as: 'sidekiq'
  end
end
