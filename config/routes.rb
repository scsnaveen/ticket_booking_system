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

  match "payments/new", :controller=> "payments", :action=> "new", :via=> [:get]
  match "payments/create", :controller=> "payments", :action=> "create", :via=> [:post]
  match "payments/show", :controller=> "payments", :action=> "show", :via=> [:get]
  match "payments/refund", :controller=> "payments", :action=> "refund", :via=> [:post]
  match "user_payment_histories", :controller=> "payments", :action=> "user_payment_histories", :via=> [:get]
  # get 'buses/set_points'
  # get 'payments/new'
  # post 'payments/create'
  get 'reservations/new'
  post 'reservations/create'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
