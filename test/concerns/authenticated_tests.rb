require 'test_helper'

module ActiveSupport
  class TestCase
    module Concerns
      module AuthenticatedTests
        def test_authenticate
          record = Factory factory_name
    
          assert_nil target_klass.authenticate(record.email, 'incorrect')
          assert_equal record, target_klass.authenticate(record.email, Factory.attributes_for(factory_name)[:password])

          assert !record.authenticate('incorrect')
          assert record.authenticate(Factory.attributes_for(factory_name)[:password])
        end
  
        def test_update_password
          record = Factory factory_name

          assert record.update_attribute(:password, 'omg')
          assert record.authenticate('omg')
        end
        
        def test_password_not_encrypted_if_not_given
          record = Factory factory_name
          record.touch
          assert record.authenticate(Factory.attributes_for(factory_name)[:password])
        end
      end
    end
  end
end