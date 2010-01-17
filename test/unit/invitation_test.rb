require 'test_helper'

class InvitationTest < ActiveSupport::TestCase
  include Concerns::TokenizedTests
  include Concerns::EmailValidationTests
end