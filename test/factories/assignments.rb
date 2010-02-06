Factory.define :assignment do |f|
  f.association :course
  f.name        'Make an online posting'
  f.description 'Create a useless post or response on the bulletin board'
  f.after_build do |a|
    a.due_date = Date.new(2004, 2, 15) if a.due_date.blank?
    a.due_minutes = 720 if a.due_minutes.blank?
  end
end