module ActiveRecord
  module TokenizedTests
    extend ActiveSupport::Concern
    
    included do
      test 'token generated' do
        assert_not_nil factory.create.token
      end
    
      test 'to_param' do
        record = factory.create
        assert_equal record.token, record.to_param
      end
    
      test 'prune' do
        old_record = factory.create created_at: 2.weeks.ago
        recent_record = factory.create created_at: 1.day.ago
      
        self.class.target_klass.prune
      
        assert_destroyed old_record
        assert_not_destroyed recent_record
      end
    
      test 'included in models' do
        assert ActiveRecord::Tokenized.models.include?(self.class.target_klass)
      end
    end
  end
end