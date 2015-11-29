Rails.application.routes.draw do

  root 'static_pages#welcome_page'
  get 'static_pages/home'

  get 'comments/new'
  post 'comments/show'
  post 'notes/show_user_notes'
  resources :notes
  resources :notebooks
  resources :comments
  resources :relationships,       only: [:create, :destroy]
  
  post 'search' => 'notes#search'
  get 'search' => 'notes#search'
  post 'upload-note' => 'notes#upload_note'
  post 'edit_notes' => 'notes#edit_notes'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks", sessions: "users/sessions" }
  resources  :users, :only => [:index, :show] do
    member do
      get :following, :followers
    end
  end

  get 'feed' => 'users#feed'

  
end
