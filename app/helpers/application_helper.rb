module ApplicationHelper

  def get_fetch_nav_class
    if ['show','index','download'].include?(action_name)
      return 'active'
    end
  end

  def get_share_nav_class
    if ['new','create'].include?(action_name)
      return 'active'
    end
  end

end
