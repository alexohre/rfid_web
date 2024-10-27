Rails.application.routes.draw do
  # devise_for :lecturers
  
  namespace :account do
    resource :subscription, only: [ :update]
    get 'dashboard', to: 'dashboard#home'
    get 'dashboard/subscription', to: 'dashboard#subscription'
    post 'revert_masquerade', to: "dashboard#revert_masquerade"
    # setting
    get 'settings/change_password', to: 'setting#change_password'
    get 'settings/profile', to: 'setting#profile'

    resources :urls, param: :short_code
  end


  namespace :admin do
    resources :payment_methods, only: [:create, :destroy]

    resources :currency_pairs, only: [:create, :destroy] do
      collection do
        post :import_csv
      end
    end

    resource :site, only: [:new, :create, :edit, :update]
    get 'dashboard', to: 'dashboard#home'
    get 'users', to: 'dashboard#users'
    get 'users/:id', to: 'dashboard#show'
    post 'masquerade_as_account', to: 'dashboard#masquerade_as_account'
    # delete account
    delete 'users/:id', to: 'dashboard#destroy'
    # mails
    get 'emails', to: 'email#sent'
    get 'email/new', to: 'email#new'
    post 'emails', to: 'email#create'
    # school config
    get "school_config", to: "school_config#index"
    post 'school_config/create_faculty', to: 'school_config#create_faculty'
    post 'school_config/create_department', to: 'school_config#create_department'
    post 'school_config/create_courses', to: 'school_config#create_courses'
    patch 'school_config/update_faculty/:id', to: 'school_config#update_faculty', as: 'update_faculty'
    patch 'school_config/update_department/:id', to: 'school_config#update_department', as: 'update_department'
    patch 'school_config/update_courses/:id', to: 'school_config#update_courses', as: 'update_courses'

    # settings
    get 'settings/account', to: 'setting#account'
    get 'settings/password', to: 'setting#admin_password'
    get 'settings/site_details', to: 'setting#site_details'
    get 'settings/currency_pairs', to: 'setting#currency_pairs'
    get 'settings/payment_method', to: 'setting#payment_methods'

  end

  devise_for :accounts, controllers: {
    sessions: 'accounts/sessions',
    registrations: 'accounts/registrations',
    passwords: 'accounts/passwords',
    confirmations: 'accounts/confirmations'
    }, path: 'auth', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    password: 'secret',
    registration: 'account',
    sign_up: 'sign_up'
  }

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
    }, path: 'admin', path_names: {
    sign_in: 'ae-login',
    sign_out: 'logout',
  }, only: [:sessions, :registrations]

  devise_for :lecturers, controllers:{
    sessions: 'lecturers/sessions'
  }, path: 'lecturers', path_names: { 
    sign_in: 'login', sign_out: 'logout', sign_up: 'register'
  }, only: [:sessions]

  root 'pages#home'

end
