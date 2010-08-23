Homeworkbin::Application.routes.draw do
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
        member do
          get :confirm_hand_in
          put :complete_hand_in
        end
      end
        # collection do
        #   get :upcoming, :past
        # end
        
        # member do
        #   get :compose
        #   post :save
        #   post :submit
        # end
      # end
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
