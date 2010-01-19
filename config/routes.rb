ActionController::Routing::Routes.draw do |map|
  map.root :controller => 'marketing'
  
  map.resources :registrations, :collection => {'thanks' => :get}
  map.resources :enrollment
  map.resources :lost_passwords
  map.resources :people
  map.resources :courses
  map.resource :session

  map.resource :student do |student|
    student.resources :courses
  end
  
  map.resources :teacher do |teacher|
    teacher.resources :courses
  end
  
  map.login 'login',    :controller => 'sessions',      :action => 'new'
  map.logout 'logout',  :controller => 'sessions',      :action => 'destroy'
  map.signup 'signup',  :controller => 'registrations', :action => 'new'

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
