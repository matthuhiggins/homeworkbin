ActionController::Routing::Routes.draw do |map|
  map.root :controller => 'marketing'
  
  map.resources :registrations, :collection => {'thanks' => :get}
  map.resources :people
  map.resources :courses
  map.resource :session
  
  map.login 'login', :controller => 'sessions', :action => 'new'
  map.signup 'signup', :controller => 'registrations', :action => 'new'

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
