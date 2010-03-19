ActionController::Routing::Routes.draw do |map|
  map.root :controller => 'marketing'
  
  map.resources :lost_passwords

  map.resources :enrollments, :controller => 'studying/enrollments', :as => 'enroll'

  map.resources :studyings, :controller => 'studying/courses', :as => 'studying' do |studying|
    studying.resources :assignments, :as => 'homework' do |assignment|
      assignment.resource :composition, :name_prefix => 'studying_', :controller => 'studying/compositions'
    end
  end
  
  map.resources :registrations, :controller => 'teaching/registrations', :as => 'signup'

  map.resources :teachings, :controller => 'teaching/courses', :as => 'teaching', :requirements => {:id => /\d+/} do |teachings|
    teachings.resources :assignments,  :controller => 'teaching/assignments',   :as => 'homework'
    teachings.resources :enrollments,  :controller => 'teaching/enrollments',   :as => 'enroll'
    teachings.resources :studiers,     :controller => 'teaching/studiers',      :as => 'students'
    teachings.resources :submissions,  :controller => 'teaching/submissions' do |submissions|
      submissions.resources :annotations, :name_prefix => 'teaching_', :controller => 'teaching/annotations'
    end
  end

  map.namespace :teaching do |teaching|
    teaching.resource  :person, :as => 'settings'
  end
    
  map.login   'login',    :controller => 'sessions',      :action => 'new', :conditions => { :method => :get }
  map.connect 'login',    :controller => 'sessions',      :action => 'create', :conditions => { :method => :post }
  map.logout  'logout',   :controller => 'sessions',      :action => 'destroy', :conditions => { :method => :delete }

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
