Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config

  ActiveAdmin.routes(self)

  get 'emails/confirm/:token', to: 'emails#confirm',
                               as: 'confirm_email_by_token'

  scope path: '/api' do
    api_version(header: {
                  name: 'Accept',
                  value: 'application/vnd.templateapp.v1+json'
                },
                module: 'Api::V1', default: true) do

      resources :users, only: [:show, :create] do
        collection do
          post :reset_password
        end
        resources :prayers, only: [:create, :show]
      end

      resources :sessions, only: :create, path: 'users/sessions'
      resources :devices, only: :create, path: 'users/devices'
      resources :pushes, only: :create
      resources :prayers, only: [:create, :show, :index]
      resources :lists

      # Profile
      get '/profile', to: 'profile#show', as: 'profile'
      put '/profile', to: 'profile#update'

      post '/:provider/sessions', to: 'social#sing_in'

      scope :errors_example do
        get '/payments/cvv', to: 'errors_example#cvv'
        get '/schedule/appointment', to: 'errors_example#appointment'
        get '/uncovered', to: 'errors_example#uncovered'
        get '/active_record/invalid', to: 'errors_example#active_record_invalid'
      end
    end
  end

  resources :passwords, only: [:edit, :update], path: 'reset_password',
                        param: :token, as: :user_passwords
end
