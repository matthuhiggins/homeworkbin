module ActiveRecord
  module DenormalizationTests
    extend ActiveSupport::Concern
    
    module ClassMethods
      def test_denormalization(intermediate_association, denormalized_association)
        define_method "test_#{denormalized_association}_denormalized_through_#{intermediate_association}" do
          record = Factory.build self.class.factory_name, denormalized_association => nil

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