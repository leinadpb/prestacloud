
Rails.application.routes.draw do
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
      namespace :client do
        get '/', to: 'clients#all'
      end
    end
  end
end
