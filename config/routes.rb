
Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_for :users,
             path: 'api',
             path_names: {
                 sign_in: 'login',
                 sign_out: 'logout',
                 registration: 'sign_up'
             },
             controllers: {
                 sessions: 'sessions',
                 registrations: 'registrations'
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

    end
  end
end
