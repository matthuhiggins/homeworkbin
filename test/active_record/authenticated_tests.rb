module ActiveRecord
  module AuthenticatedTests
    extend ActiveSupport::Concern

    included do
      test 'authenticate' do
        record = factory.create

        assert_nil self.class.target_klass.authenticate(record.email, 'incorrect')
        assert_equal record, self.class.target_klass.authenticate(record.email, factory.attributes[:password])

        assert !record.authenticate('incorrect')
        assert record.authenticate(self.class.factory.attributes[:password])
      end

      test 'update_password' do
        record = factory.create

        assert record.update_attribute(:password, 'omg')
        assert record.authenticate('omg')
      end
    
      test 'password_not_encrypted_if_not_given' do
        record = factory.create

        record.touch

        assert record.authenticate(self.class.factory.attributes[:password])
      end
    end
  end
end