class Submission < Composition
  default_scope :conditions => ['handed_in_at is not null']
  
  HTML_REGEX = /<\/?[^>]*>/
  def preview(length)
    text.gsub('<br>', ' ').gsub(HTML_REGEX, '')[0, length]
  end
end