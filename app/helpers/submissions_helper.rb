module SubmissionsHelper
  include TimeHelper

  def submission_handed_in_at(submission)
    date = relative_date submission.handed_in_at.to_date
    
    date + ' at ' + hour(submission.handed_in_at)
  end
  
  HTML_REGEX = /<\/?[^>]*>/
  def submission_preview(submission, length)
    submission.text.gsub('<br>', ' ').gsub(HTML_REGEX, '')[0, length]
  end
end