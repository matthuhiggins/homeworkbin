Homeworkbin::Application.routes.draw do |map|
  root :to => 'home#index'

  resources :lost_passwords
  resource :person, :path => 'settings'

  controller :sessions do
    get     'login',  :to => :new,      :as => 'login'
    post    'login',  :to => :create
    delete  'logout', :to => :destroy,  :as => 'logout'
  end

  scope :module => 'studying' do
    resources :enrollments, :path => 'enroll'
    resources :studyings, :controller => 'courses', :path => 'studying' do
      resources :assignments, :path => 'homework' do
        resource :composition
      end
    end
  end

  scope :module => 'teaching' do
    resources :registrations, :path => 'signup'
    resources :teachings, :controller => 'courses', :path => 'teaching' do
      resources :assignments,   :path => 'homework'
      resources :enrollments,   :path => 'enroll'
      resources :studiers,      :path => 'students'
      resources :submissions do
        resources :annotations, :name_prefix => 'teaching_'
      end
    end
  end

  match ':controller(/:action(/:id(.:format)))'
end
