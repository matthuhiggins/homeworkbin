module ActiveRecord
  module PreviousTests
    def test_previous
      first_record = Factory self.class.factory_name
      second_record = Factory self.class.factory_name
      third_record = Factory self.class.factory_name
      
      assert_equal third_record, self.class.target_klass.previous
    end
  end
end