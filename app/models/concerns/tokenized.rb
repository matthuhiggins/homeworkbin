module Concerns::Tokenized
  def self.included(model)
    model.before_create :create_token
  end
  
  def create_token
    self.token = ActiveSupport::SecureRandom.hex(16)
  end
end