ActionController::Routing::Routes.draw do |map|
  map.root :controller => 'marketing'
  
  map.resources :people
  map.resources :courses
  map.resource :session
  
  map.login 'login', :controller => 'sessions', :action => 'new'
  map.signup 'signup', :controller => 'people', :action => 'new'

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
