module ActiveRecord
  module TokenizedTests
    def test_token_generated
      assert_not_nil Factory(factory_name).token
    end
    
    def test_to_param
      record = Factory factory_name
      assert_equal record.token, record.to_param
    end
    
    def test_prune
      old_record = Factory factory_name, :created_at => 2.weeks.ago
      recent_record = Factory factory_name, :created_at => 1.day.ago
      
      target_klass.prune
      
      assert_raise(ActiveRecord::RecordNotFound) { old_record.reload }
      assert_nothing_raised { recent_record.reload }
    end
    
    def test_included_in_models
      assert Concerns::Tokenized.models.include?(target_klass)
    end
  end
end
