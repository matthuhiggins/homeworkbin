class Composition < ActiveRecord::Base
  include Composition::HandIn

  extend ActiveRecord::Denormalization
  belongs_to :studier, :denormalize => :student
  belongs_to :assignment, :denormalize => :course
  
  named_scope :ungraded, :conditions => {:graded => false}
  named_scope :graded, :conditions => {:graded => true}
end