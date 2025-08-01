module ApplicationHelper
  def condition_badge_color(condition)
    case condition
    when 'brand_new'
      'success'
    when 'like_new'
      'primary'
    when 'good'
      'info'
    when 'fair'
      'warning'
    when 'poor'
      'danger'
    else
      'secondary'
    end
  end

  def flash_class(level)
    case level
    when 'notice'
      'alert-success'
    when 'alert'
      'alert-danger'
    when 'warning'
      'alert-warning'
    else
      'alert-info'
    end
  end
end
