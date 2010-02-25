class Submission < Composition
  # TODO test
  default_scope :conditions => ['handed_in_at is not null']
end