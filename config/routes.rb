Rails.application.routes.draw do

  devise_for :users#, controllers: {sessions: "sessions"}
  devise_scope :user do
    post 'user_sign_up' => 'registrations#create_user'
    post '/sessions' => 'sessions#create'
    delete '/sessions' => 'sessions#destroy'
  end

end
