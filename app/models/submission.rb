class Submission < Composition
  default_scope :conditions => ['handed_in_at is not null']
end