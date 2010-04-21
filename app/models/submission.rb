class Submission < Composition
  default_scope where('handed_in_at is not null')
  has_many :annotations
end