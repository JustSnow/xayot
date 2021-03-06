Xayot::Application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users

  root to: 'welcome#index'

  resources :posts, only: [:show]
  resources :categories, only: [:index, :show]

  namespace :admin do
    root to: 'admin#index'

    resources :users, except: [:show]
    resources :cities, except: [:show]
    
    resources :actions, except: [:show] do
      get :manage, on: :collection
      post :rebuild, on: :collection

      get 'publish', on: :member
      get 'unpublish', on: :member
    end

    resources :categories do
      get :manage, on: :collection
      post :rebuild, on: :collection

      get 'publish', on: :member
      get 'unpublish', on: :member
    end

    resources :posts, except: [:show] do
      get 'publish', on: :member
      get 'unpublish', on: :member

      resources :gallery_posts, only: [:index, :create, :destroy]
    end

    resources :menus do
      collection do
        get :manage
        post :rebuild
        get :rebuild_select
      end
      
      get 'publish', on: :member
      get 'unpublish', on: :member
    end
  end
end
