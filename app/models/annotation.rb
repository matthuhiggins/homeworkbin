class Annotation < ActiveRecord::Base
  belongs_to :composition
  validates_presence_of :text
end