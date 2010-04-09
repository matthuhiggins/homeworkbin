module ActiveRecord
  module EmailValidationTests
    def test_valid_email_formats
      %w(matthewh@napera.com crazy-email@acme123.net).each do |email|
        record = factory.build :email => email
        record.valid?
        assert !Array.wrap(record.errors[:email]).include?(I18n.translate('activerecord.errors.messages.invalid'))
      end
    end

    def test_invalid_email_formats
      %w(joe joe@x.c joe@acme @acme.net acme.net ).each do |email|
        record = factory.build :email => email
        assert record.invalid?
        assert record.errors[:email].include?('is invalid')
      end
    end
  end
end