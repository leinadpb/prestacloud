
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

      namespace :payment do
        post '/quote', to: 'payments#pay_quote'
      end

      namespace :user do
        get '/', to: 'users#show'
      end

      namespace :dashboard do
        get '/', to: 'dashboard#get_data'
      end

      namespace :business do
        post '/', to: 'business#create'
        get '/', to: 'business#show'
      end

      namespace :loan do
        post '/', to: 'loans#create'
        get '/', to: 'loans#show'
        get '/options', to: 'loans#options'
        get '/table_data', to: 'loans#table_data'
      end

      namespace :quote do
        get '/', to: 'quotes#show'
      end

      namespace :client do
        post '/', to: 'clients#create'
        get '/', to: 'clients#show'
        get '/search', to: 'clients#search_by'
        get '/loans', to: 'clients#show_loans'
      end


      # Routes for client_users

      namespace :client_users do

        namespace :loan_user do
          get '/', to: 'loan_users#show'
        end

        namespace :card do
          post '/', to: 'cards#create_card'
          post '/create_customer', to: 'cards#add_customer'
          get '/cards', to: 'cards#get_cards'
        end

      end

    end
  end
end
