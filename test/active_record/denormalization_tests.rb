module ActiveRecord
  module DenormalizationTests
    extend ActiveSupport::Concern
    
    module ClassMethods
      def tests_denormalization(intermediate_association, denormalized_association)
        test "test_#{denormalized_association}_denormalized_through_#{intermediate_association}" do
          record = factory.build denormalized_association => nil

          assert_not_nil record.send(intermediate_association)
          assert_not_nil record.send(intermediate_association).send(denormalized_association)
          assert_nil record.send(denormalized_association)

          record.save!
        
          assert_not_nil record.send(denormalized_association)
          assert_equal(
            record.send(intermediate_association).send(denormalized_association),
            record.send(denormalized_association)
          )
        end
      end
    end
  end
end