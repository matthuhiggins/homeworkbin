module ActiveRecord
  module PreviousTests
    def test_previous
      earliest_record = Factory self.class.factory_name
      middle_record = Factory self.class.factory_name
      latest_record = Factory self.class.factory_name
      
      assert_equal latest_record, self.class.target_klass.previous
    end
  end
end