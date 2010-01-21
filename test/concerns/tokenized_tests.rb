module ActiveSupport
  class TestCase
    module Concerns
      module TokenizedTests
        def test_token_generated
          assert_not_nil Factory(target_class.to_s.underscore).token
        end
        
        def test_to_param
          record = Factory(target_class.to_s.underscore)
          assert_equal record.token, record.to_param
        end
      end
    end
  end
end