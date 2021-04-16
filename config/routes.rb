Rails.application.routes.draw do
  devise_for :users, controllers: { 
		registrations: 'users/registrations', 
		sessions: 'users/sessions'
	}
  get 'welcome/index'
  root 'welcome#index'

  get 'buses/new'
  post 'buses/create'
  resources :buses,only: [:search,:index] do
    collection do
      match 'search' => 'buses#search', via: [:get, :post], as: :search
    end
  end

  match "/payment", :controller=> "payments", :action=> "payment", :via=> [:get,:post]
  match "/show", :controller=> "payments", :action=> "show", :via=> [:get]
  match "payments/refund", :controller=> "payments", :action=> "refund", :via=> [:post]

  get 'payments/new'
  post 'payments/create'
  get 'reservations/new'
  post 'reservations/create'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
