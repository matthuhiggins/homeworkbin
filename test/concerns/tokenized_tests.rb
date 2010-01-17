module ActiveSupport
  class TestCase
    module Concerns
      module TokenizedTests
        def test_token_generated
          assert_not_nil Factory(target_class.to_s.underscore).token
        end
      end
    end
  end
end