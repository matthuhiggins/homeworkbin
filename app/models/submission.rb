class Submission < ActiveRecord::Base
  belongs_to :student, :class_name => 'Person'
end