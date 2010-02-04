ActionController::Routing::Routes.draw do |map|
  map.root :controller => 'marketing'
  
  map.resources :lost_passwords
  map.resource :session

  map.resources :enrollments, :controller => 'studying/enrollments'

  map.resources :studyings, :controller => 'studying/courses', :as => 'studying' do |studying|
    studying.resources :assignments do |assignment|
      assignment.resource :composition, :name_prefix => 'studying_'
    end
  end
  
  map.resources :registrations, :controller => 'teaching/registrations', :collection => {'thanks' => :get}

  map.resources :teachings, :controller => 'teaching/courses', :as => 'teaching', :requirements => {:id => /\d+/} do |teachings|
    teachings.resources :assignments,  :controller => 'teaching/assignments'
    teachings.resources :enrollments,  :controller => 'teaching/enrollments'
    teachings.resources :studiers,     :controller => 'teaching/studiers',   :as => 'students'
  end

  map.namespace :teaching do |teaching|
    teaching.resource  :person, :as => 'settings'
  end
    
  map.login   'login',    :controller => 'sessions',      :action => 'new', :conditions => { :method => :get }
  map.connect 'login',    :controller => 'sessions',      :action => 'create', :conditions => { :method => :post }
  map.logout  'logout',   :controller => 'sessions',      :action => 'destroy'
  map.signup  'signup',   :controller => 'teaching/registrations', :action => 'new'

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
