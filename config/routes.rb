Rails.application.routes.draw do
  resources :question_types
  resources :tags
  resources :subject_sub_areas
  resources :subject_areas
  resources :lectures
  resources :courses
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
