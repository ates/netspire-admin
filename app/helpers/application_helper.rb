module ApplicationHelper
  def localized_time(value, format = :short, blank = nil)
    value.present? ? l(value, :format => format) : blank
  end

  def tick_or_cross(value)
    icon = value ? "ok" : "remove"
    "<i class='icon-#{icon}'></i>".html_safe
  end
end
