module Teaching::RegistrationHelper
  def check_your_email(email)
    url = case email
      when /@gmail\.com$/ then 'http://gmail.com'
      when /@yahoo\.com$/ then 'http://mail.yahoo.com'
    end
    
    link_to_if url.present?, 'Check your email', url
  end
end