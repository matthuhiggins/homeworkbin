module ActiveRecord
  module AuthenticatedTests
    def test_authenticate
      record = factory.create

      assert_nil self.class.target_klass.authenticate(record.email, 'incorrect')
      assert_equal record, self.class.target_klass.authenticate(record.email, factory.attributes[:password])

      assert !record.authenticate('incorrect')
      assert record.authenticate(self.class.factory.attributes[:password])
    end

    def test_update_password
      record = factory.create

      assert record.update_attribute(:password, 'omg')
      assert record.authenticate('omg')
    end
    
    def test_password_not_encrypted_if_not_given
      record = factory.create

      record.touch

      assert record.authenticate(self.class.factory.attributes[:password])
    end
  end
end