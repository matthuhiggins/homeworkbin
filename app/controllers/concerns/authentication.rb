module Concerns
  module Authentication
    def self.included(controller)
      controller.class_eval do
        extend ClassMethods
        include InstanceMethods
        helper_method :authenticated?, :current_person
      end
    end
    
    module ClassMethods
      def require_login(options = {})
        before_filter :check_authentication, options
      end
    end
    
    module InstanceMethods
      protected
        def authenticated?
          !current_person.nil?
        end
    
        def current_person
          @current_person ||= (person_from_session || person_from_cookie)
        end
        
        def login(person, remember = false)
          initiate_authenticated_session(person)
          remember_person(person) if remember
          redirect_to_home
        end

        def redirect_to_home
          uri = session[:original_uri] || default_home
          session[:original_uri] = nil
          redirect_to(uri)
        end

      private
        def default_home
          "/"
        end
      
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
            session[:original_uri] = request.request_uri
            redirect_to(login_path)
          end
        end
        
        def initiate_authenticated_session(person)
          cookies[:last_email] = {:value => person.email, :expires => 1.week.from_now}
          # person.update_attribute(:authenticated_at, Time.current)
          session[:person_id] = person.id
          flash[:notice] = "Hello %1$s" % person.full_name
        end
        
        def terminate_authenticated_session
          current_person.try(:forget_me!)
          session[:person_id] = nil 
          cookies.delete [:last_email, :remember_token]
        end
    end
  end
end