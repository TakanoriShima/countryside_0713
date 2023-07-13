Rails.application.routes.draw do
  get 'messages/index'
  get 'messages/create'
  root to: "home#index"
  
  devise_for :users, :controllers => {
    :confirmations => 'users/confirmations',
    :registrations => 'users/registrations',
    :sessions => 'users/sessions',
    :passwords => 'users/passwords'
   }
   
  devise_for :admins 
   
  resources :user_profiles
  
  resources :posts, except: [:new, :create]
  resources :posts_region
  resources :posts_business
  
  resources :post do
     resources :comments, except: [:show, :index]
  end
  
  resources :favorites, only: [:create, :destroy]
  
  resources :accounts, only: [:show]

  scope :admins do
    resources :tag_post_regions, only: [:new, :index]
    resources :tag_post_businesses, only: [:new, :index]
    resources :category_resources, only: [:create, :edit, :update, :destroy]
    resources :category_issues, only: [:create, :edit, :update, :destroy]
    resources :category_markets, only: [:create, :edit, :update, :destroy]
    resources :category_features, only: [:create, :edit, :update, :destroy]
    resources :category_wants, only: [:create, :edit, :update, :destroy]
    resources :category_realizabilities, only: [:create, :edit, :update, :destroy]
    resources :category_earnest, only: [:create, :edit, :update, :destroy]
    resources :tag_profile_regions, only: [:new, :index]
    resources :tag_profile_businesses, only: [:new, :index]
    resources :category_about_regions, only: [:create, :edit, :update, :destroy]
    resources :category_incubations, only: [:create, :edit, :update, :destroy]
    resources :category_immigration_supports, only: [:create, :edit, :update, :destroy]
    resources :category_jobs, only: [:create, :edit, :update, :destroy]
    resources :category_skills, only: [:create, :edit, :update, :destroy]
    resources :category_interests, only: [:create, :edit, :update, :destroy]
  end
  
  resources :post_category_resources
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  
  resources :users do
    member do
      resources :messages, only: [:create, :index]
    end
  end
end
