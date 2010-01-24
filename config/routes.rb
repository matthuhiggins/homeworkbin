ActionController::Routing::Routes.draw do |map|
  map.root :controller => 'marketing'
  
  map.resources :registrations, :collection => {'thanks' => :get}
  map.resources :enrollment
  map.resources :lost_passwords
  map.resources :people
  map.resources :courses
  map.resource :session

  map.resources :studyings, :controller => 'studying/courses', :as => 'studying' do |studying|
    studying.resources :assignments do |assignment|
      assignment.resource :composition, :name_prefix => 'studying_'
    end
  end
  
  map.resources :teachings, :controller => 'teaching/courses', :as => 'teaching' do |teaching|
    teaching.resources :assignments, :controller => 'teaching/assignments'
    teaching.resources :enrollments
  end
  
  map.login 'login',    :controller => 'sessions',      :action => 'new'
  map.logout 'logout',  :controller => 'sessions',      :action => 'destroy'
  map.signup 'signup',  :controller => 'registrations', :action => 'new'

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
