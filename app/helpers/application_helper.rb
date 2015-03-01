module ApplicationHelper

  def votes_left
    current_user.votes_remaining?
  end

  def views_veto
    current_user.can_veto? ? 1 : 0
  end

  def humanize_veto
    current_user.can_veto? ? "veto" : "vetos"
  end

  def bootstrap_class_for(flash_type)
    case flash_type.to_sym
      when :success
        "alert-dismissible alert-success"
      when :error
        "alert-dismissible alert-warning"
      when :alert
        "alert-dismissible alert-danger"
      when :notice
        "alert-dismissible alert-info"
      else
        flash_type.to_s
    end
  end

end
