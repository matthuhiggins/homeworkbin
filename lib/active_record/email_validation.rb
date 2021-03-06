module ActiveRecord
  module EmailValidation
    extend ActiveSupport::Concern

    included do
      validates_format_of :email, with: /^[\w\d._%+-]+@[\w\d.-]+\.[\w]{2,6}$/
      validates_presence_of :email
    end
  end
end