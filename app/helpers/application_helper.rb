module ApplicationHelper

  def votes_left
    3 #TODO - come back once db tables are up
  end

  def bootstrap_class_for(flash_type)
  #  binding.pry
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
