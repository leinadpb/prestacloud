
Rails.application.routes.draw do

  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_for :users,
             path: 'users',
             path_names: {
                 sign_in: 'login',
                 sign_out: 'logout',
                 registration: 'sign_up'
             },
             controllers: {
                 sessions: 'users/sessions',
                 registrations: 'users/registrations'
             }, defaults: { format: :json }

  devise_for :user_clients,
             path: 'clients',
             path_names: {
                 sign_in: 'login',
                 sign_out: 'logout',
                 registration: 'sign_up'
             },
             controllers: {
                 sessions: 'user_clients/sessions',
                 registrations: 'user_clients/registrations'
             }, defaults: { format: :json }

  mount ActionCable.server => '/cable'

  namespace :api do

    namespace :v1 do

      get '/', to: 'test#secured'
      get '/unsecured', to: 'test#unsecured'
      get '/add', to: 'test#append_role'

      namespace :business do
        post '/', to: 'business#create'
        get '/', to: 'business#show'
      end

      namespace :loan do
        post '/', to: 'loans#create'
        get '/', to: 'loans#show'
      end

      namespace :client do
        post '/', to: 'clients#create'
        get '/', to: 'clients#show'
      end

    end
  end
end
