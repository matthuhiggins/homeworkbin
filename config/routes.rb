ActionController::Routing::Routes.draw do |map|
  map.root :controller => 'marketing'
  
  map.resources :registrations, :collection => {'thanks' => :get}
  map.resources :enrollment
  map.resources :lost_passwords
  map.resources :people
  map.resources :courses
  map.resource :session

  map.resources :studyings, :controller => 'studying' do |studying|
    studying.resources :courses
    studying.resources :assignments 
  end
  
  map.resources :teachings do |teaching|
    teaching.resources :courses
  end
  
  map.login 'login',    :controller => 'sessions',      :action => 'new'
  map.logout 'logout',  :controller => 'sessions',      :action => 'destroy'
  map.signup 'signup',  :controller => 'registrations', :action => 'new'

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
