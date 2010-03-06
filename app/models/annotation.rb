class Annotation < ActiveRecord::Base
  validates_presence_of :text
  belongs_to :composition
end