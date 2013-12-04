SampleApp::Application.routes.draw do
    resources :users
    resources :sessions, only: [:new, :create, :destroy]
    resources :microposts, only: [:create, :destroy]

    root 'static_pages#home'
    match '/signup',   to: 'users#new',            as:'signup',    via: 'get'
    match '/signin',   to: 'sessions#new',         as:'signin',    via: 'get'
    match '/signout',  to: 'sessions#destroy',     as:'signout',   via: 'delete'
    match '/help',     to: 'static_pages#help',    as:'help',      via: 'get'
    match '/about',    to: 'static_pages#about',   as:'about',     via: 'get'
    match '/contact',  to: 'static_pages#contact', as:'contact',   via: 'get'
end