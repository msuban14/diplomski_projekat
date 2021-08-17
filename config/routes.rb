Rails.application.routes.draw do
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
end
