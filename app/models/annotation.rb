class Annotation < ActiveRecord::Base
  validates_presence_of :text
  belongs_to :submission
end