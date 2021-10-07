Rails.application.routes.draw do
  devise_for :users, :skip => [:registrations], controllers: {
    sessions: 'users/sessions'
  }
  devise_scope :user do
    get 'sign_in', to: 'devise/sessions#new'
  end
  resources :answers
  resources :questions do
    collection do
      get 'lectures/:id' , to: 'questions#lectures', as: 'lecture_import'
    end
  end
  resources :question_difficulties
  resources :question_types
  resources :tags
  resources :subject_sub_areas
  resources :subject_areas
  resources :lectures
  resources :courses
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html


  get 'imports' , to: 'imports#new'
  post 'imports', to: 'imports#create'

  get 'exports', to: 'exports#showall'
  get 'exports/:id' , to: 'exports#new', as: 'export'
  post 'exports', to: 'exports#create'
  get 'exports/download/aiken', to: 'exports#download_aiken'
  get 'exports/download/xml', to: 'exports#download_xml'


  #tmp root
  root to: 'imports#new'
end
