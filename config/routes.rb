Homeworkbin::Application.routes.draw do |map|
  root :to => 'home#index'

  resources :lost_passwords
  resource :person, :as => 'settings'

  controller :sessions do
    get     'login',  :to => :new,      :as => 'login'
    post    'login',  :to => :create
    delete  'logout', :to => :destroy,  :as => 'logout'
  end

  resources :enrollments, :controller => 'studying/enrollments', :as => 'enroll'

  resources :studyings, :controller => 'studying/courses', :as => 'studying' do
    resources :assignments, :as => 'homework' do
      resource :composition, :name_prefix => 'studying_', :controller => 'studying/compositions'
    end
  end

  # controller_namespace
  resources :registrations, :controller => 'teaching/registrations', :as => 'signup'
  resources :teachings, :controller => 'teaching/courses', :as => 'teaching' do
    resources :assignments,  :controller => 'teaching/assignments',   :as => 'homework'
    resources :enrollments,  :controller => 'teaching/enrollments',   :as => 'enroll'
    resources :studiers,     :controller => 'teaching/studiers',      :as => 'students'
    resources :submissions,  :controller => 'teaching/submissions' do
      resources :annotations, :name_prefix => 'teaching_', :controller => 'teaching/annotations'
    end
  end
end
