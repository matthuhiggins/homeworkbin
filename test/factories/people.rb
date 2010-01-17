Factory.sequence :email do |n|
  "student#{n}@alaska.edu"
end

Factory.define :person do |f|
  f.full_name           'Matty Higgins'
  f.email               { Factory.next :email }
  f.password            'sekret'
  # f.salt                'NaCl'
  # f.encrypted_password  Person.encrypt_password('sekret', 'NaCl')
end