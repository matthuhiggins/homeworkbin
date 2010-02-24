class Composition < ActiveRecord::Base
  extend ActiveRecord::Denormalization
  include Composition::HandIn

  belongs_to :studier, :denormalize => :student
  belongs_to :assignment, :denormalize => :course
  
  named_scope :ungraded, :conditions => {:graded => false}
  named_scope :graded, :conditions => {:graded => true}
end