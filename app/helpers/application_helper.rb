module ApplicationHelper
  def tick_or_cross(value)
    icon = value ? "ok" : "remove"
    "<i class='icon-#{icon}'></i>".html_safe
  end
end
