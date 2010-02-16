module LinkHelper
  def cancel
    if @controller.request.referer.present?
      link_to 'Cancel', 'javascript:history.back()', :class => 'cancel'
    else
      ''
    end
  end
  
  def logout
    link_to 'Logout', logout_path, :method => :delete
  end
end