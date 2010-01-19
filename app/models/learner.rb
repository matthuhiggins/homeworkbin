class Learner < ActiveRecord::Base
  belongs_to :course, :counter_cache => :students_count
  belongs_to :student, :counter_cache => :courses_learned
end