Factory.define :assignment do |f|
  f.association :course
  f.title       'Make an online posting'
  f.description 'Create a useless post or response on the bulletin board'
  f.due         Time.mktime(2004, 2, 15, 12, 0, 0)
end