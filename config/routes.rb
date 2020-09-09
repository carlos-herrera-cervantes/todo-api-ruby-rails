Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  resources :users
  resources :todos
  post '/users/:id/todos' => 'todos#create_by_user'
  post '/auth/login' => 'authentication#login'
end