module ActionController
  module RequestMethods
    def request_methods(prefix)
      %w(get post put delete).each do |http_method|
        class_eval <<-METHOD, __FILE__, __LINE__ + 1
          def #{prefix}_#{http_method}(action, params = {})
            #{prefix}_request('#{http_method.upcase}', action, params)
          end
        METHOD
      end
    end
  end
end