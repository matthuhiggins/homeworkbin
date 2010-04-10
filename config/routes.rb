Homeworkbin::Application.routes.draw do |map|
  root :to => 'home#index'

  resources :lost_passwords
  resource :person, :path => 'settings'

  controller :sessions do
    get     'login',  :to => :new,      :as => 'login'
    post    'login',  :to => :create
    delete  'logout', :to => :destroy,  :as => 'logout'
  end

  resources :enrollments, :controller => 'studying/enrollments', :path => 'enroll'
  resources :studyings, :controller => 'studying/courses', :path => 'studying' do
    resources :assignments, :controller => 'studying/assignments', :path => 'homework' do
      resource :composition, :controller => 'studying/compositions'
    end
  end

  # controller_namespace
  resources :registrations, :controller => 'teaching/registrations', :path => 'signup'
  resources :teachings, :controller => 'teaching/courses', :path => 'teaching' do
    resources :assignments,  :controller => 'teaching/assignments',   :path => 'homework'
    resources :enrollments,  :controller => 'teaching/enrollments',   :path => 'enroll'
    resources :studiers,     :controller => 'teaching/studiers',      :path => 'students'
    resources :submissions,  :controller => 'teaching/submissions' do
      resources :annotations, :name_prefix => 'teaching_', :controller => 'teaching/annotations'
    end
  end

  match ':controller(/:action(/:id(.:format)))'
end
