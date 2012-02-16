module ApplicationHelper
  def localized_time(value, format = :short, blank = nil)
    value.present? ? l(value, :format => format) : blank
  end

  def tick_or_cross(value)
    icon = value ? "ok" : "remove"
    "<i class='icon-#{icon}'></i>".html_safe
  end

  def page_navigation(pages)
    will_paginate(pages, :class => 'pagination', :inner_window => 2,
                         :outer_window => 0, :renderer => BootstrapLinkRenderer,
                         :previous_label => '&larr;', :next_label => '&rarr;')
  end
end
