module SubmissionsHelper
  include TimeHelper

  def submission_handed_in_at(submission)
    date = begin
      if submission.handed_in_at.today?
        'today'
      elsif submission.handed_in_at.to_date == Date.current.yesterday
        'yesterday'
      else
        submission.handed_in_at.strftime('%a, %b %d')
      end
    end
    
    date + ' at ' + hour(submission.handed_in_at)
  end
  
  HTML_REGEX = /<\/?[^>]*>/
  def submission_preview(submission, length)
    submission.text.gsub('<br>', ' ').gsub(HTML_REGEX, '')[0, length]
  end
end