module ActiveRecord
  module TokenizedTests
    def test_token_generated
      assert_not_nil Factory(factory_name).token
    end
    
    def test_to_param
      record = Factory(target_klass.to_s.underscore)
      assert_equal record.token, record.to_param
    end
  end
end
