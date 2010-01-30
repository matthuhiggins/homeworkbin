module ActiveRecord
  module EmailValidationTests
    def test_valid_email_formats
      %w(matthewh@napera.com crazy-email@acme123.net).each do |email|
        record = Factory.build factory_name, :email => email
        record.valid?
        assert !Array.wrap(record.errors.on(:email)).include?(I18n.translate('activerecord.errors.messages.invalid'))
      end
    end

    def test_invalid_email_formats
      %w(joe joe@x.c joe@acme @acme.net acme.net ).each do |email|
        record = Factory.build factory_name, :email => email
        assert record.invalid?
        assert Array.wrap(record.errors.on(:email)).include?(I18n.translate('activerecord.errors.messages.invalid'))
      end
    end
  end
end