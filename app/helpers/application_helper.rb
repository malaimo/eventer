module ApplicationHelper
  def link_to_menu_item(tag, name, url, options=nil)
      content_tag(tag, :class => (current_page?(url) ? "selected" : "")) do
        link_to name, url, options
      end
    end
end
