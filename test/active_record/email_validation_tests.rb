module ActiveRecord
  module EmailValidationTests
    extend ActiveSupport::Concern

    included do
      test 'valid_email_formats' do
        %w(matthewh@napera.com crazy-email@acme123.net).each do |email|
          record = factory.build email: email
          record.valid?
          assert !Array.wrap(record.errors[:email]).include?(I18n.translate('activerecord.errors.messages.invalid'))
        end
      end

      test 'invalid_email_formats' do
        %w(joe joe@x.c joe@acme @acme.net acme.net ).each do |email|
          record = factory.build email: email
          assert record.invalid?
          assert record.errors[:email].include?('is invalid')
        end
      end
    end
  end
end