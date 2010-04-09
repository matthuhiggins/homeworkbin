Factory.define :lost_password do |f|
  f.email   { Factory.person.create.email }
end