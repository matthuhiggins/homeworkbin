module ActiveRecord
  module TokenizedTests
    def test_token_generated
      assert_not_nil factory.create.token
    end
    
    def test_to_param
      record = factory.create
      assert_equal record.token, record.to_param
    end
    
    def test_prune
      old_record = factory.create :created_at => 2.weeks.ago
      recent_record = factory.create :created_at => 1.day.ago
      
      self.class.target_klass.prune
      
      assert_destroyed old_record
      assert_not_destroyed recent_record
    end
    
    def test_included_in_models
      assert ActiveRecord::Tokenized.models.include?(self.class.target_klass)
    end
  end
end
