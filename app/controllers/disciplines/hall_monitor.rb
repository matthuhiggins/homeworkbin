module Disciplines
  module HallMonitor
    extend ActiveSupport::Concern
    
    included do
      helper_method :authenticated?, :current_person
    end

    module ClassMethods
      def require_login(options = {})
        prepend_before_filter :check_authentication, options
      end
    end
  
    protected
      def authenticated?
        !current_person.nil?
      end
  
      def current_person
        @current_person ||= (person_from_session || person_from_cookie)
      end
      
      # Options:
      #   :remember - Use :remember => true to save the user's login in a cookie
      #   :redirect - Define the url to redirect to
      def login(person, options = {})
        initiate_authenticated_session(person)
        remember_person(person) if options[:remember]
        redirect_after_login(options[:redirect])
      end

      def redirect_after_login(redirect_path = nil)
        uri = redirect_path || session[:original_uri] || root_path
        session[:original_uri] = nil
        redirect_to(uri)
      end

    private
      def person_from_session
        if session[:person_id]
          Person.find_by_id(session[:person_id])
        end
      end
    
      def person_from_cookie
        if cookies[:remember_token]
          Person.find_by_remember_token(cookies[:remember_token])
        end
      end
      
      def remember_person(person)
        person.remember_me!
        cookies[:remember_token] = {:value => person.remember_token, :expires => 2.weeks.from_now}
      end
      
      def check_authentication
        unless authenticated?
          session[:original_uri] = request.fullpath
          redirect_to login_path
        end
      end
      
      def initiate_authenticated_session(person)
        cookies[:last_login] = {:value => person.email, :expires => 1.week.from_now}
        # person.update_attribute(:authenticated_at, Time.current)
        session[:person_id] = person.id
        flash[:notice] = "Hello #{person.full_name}"
      end
      
      def terminate_authenticated_session
        current_person.try(:forget_me!)
        session[:person_id] = nil 
        cookies.delete [:last_login, :remember_token]
      end
  end
end