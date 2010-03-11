class Submission < Composition
  default_scope :conditions => ['handed_in_at is not null']
  has_many :annotations
  
  def annotate(text)
    annotations.create :text => text
  end
end