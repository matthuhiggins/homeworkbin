Homeworkbin::Application.routes.draw do
  root :to => 'home#index'

  resources :lost_passwords

  resource :person, :path => 'settings', as: 'settings' do
    match :password, :on => :member
  end

  controller :sessions do
    get     'login',  :to => :new,      :as => 'login'
    post    'login',  :to => :create
    delete  'logout', :to => :destroy,  :as => 'logout'
  end

  scope :module => 'studying' do
    resources :enrollments, :path => 'enroll'
    resources :studyings, :controller => 'courses', :path => 'studying' do
      resources :assignments, :path => 'homework' do
        member do
          get :confirm_hand_in
          put :complete_hand_in
          get :review
        end
      end
    end
  end

  scope :module => 'teaching' do
    resources :registrations, :path => 'signup'
    resources :teachings, :controller => 'courses', :path => 'teaching' do
      resources :assignments,   :path => 'homework'
      resources :enrollments,   :path => 'enroll'
      resources :studiers,      :path => 'students'
      resources :compositions, :path => 'submissions' do
        resources :annotations, :as => 'teaching_annotations'
      end
    end
  end 
end
