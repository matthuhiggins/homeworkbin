module Teaching::SubmissionHelper
  include TimeHelper

  def submission_handed_in_at(composition)
    date = begin
      if composition.handed_in_at.today?
        'today'
      elsif composition.handed_in_at.to_date == Date.current.yesterday
        'yesterday'
      else
        composition.handed_in_at.strftime('%a, %b %d')
      end
    end
    
    date + ' at ' + hour(composition.handed_in_at)
  end
end