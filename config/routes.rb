SampleApp::Application.routes.draw do
  get "users/new"

  root 'static_pages#home'
  match '/signup', 	to: 'users#new',			as:'signup',	via:'get'
  match '/help',    to: 'static_pages#help',    as:'help',    	via: 'get'
  match '/about',   to: 'static_pages#about',   as:'about',   	via: 'get'
  match '/contact', to: 'static_pages#contact', as:'contact', 	via: 'get'
end