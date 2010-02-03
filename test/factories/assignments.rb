Factory.define :assignment do |f|
  f.association :course
  f.name        'Make an online posting'
  f.description 'Create a useless post or response on the bulletin board'
  f.due_date    Date.new(2004, 2, 15)
end