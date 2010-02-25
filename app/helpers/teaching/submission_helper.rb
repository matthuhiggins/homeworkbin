module Teaching::SubmissionHelper
  # TODO
  def submission_handed_in_at(composition)
    if composition.handed_in_at.today?
      'today at ' + '12:00pm'
      # time_ago_in_words(composition.handed_in_at) + ' ago'
    elsif composition.handed_in_at.to_due = Date.current.yesterday
      'yesterday at ' + '12:00pm'
    else
      composition.handed_in_at.strftime('%a, %b %d')
    end
  end
end