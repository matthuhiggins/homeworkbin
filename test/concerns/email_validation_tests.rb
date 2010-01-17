module ActiveSupport
  class TestCase
    module Concerns
      module EmailValidationTests
        p "OMG"
        def test_email_format#(klass, column)
          p "WTF"
          ok = %w(matthewh@napera.com crazy-email@acme123.net)
          bad = %w(joe joe@x.c joe@acme @acme.net acme.net )

          ok.each do |email|
            record = target_class.new(:email => email)
            record.valid?
            assert_not_equal record.errors.on(:email), I18n.translate('activerecord.errors.messages.invalid')
          end

          bad.each do |email|
            record = target_class.new(:email => email)
            assert !record.valid?
            assert_equal record.errors.on(:email), I18n.translate('activerecord.errors.messages.invalid')
          end
        end
      end
    end
  end
end