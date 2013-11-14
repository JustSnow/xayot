module ApplicationHelper
	def current_active path
    'active' if current_page?(path)
  end

  def make_menu_link menu
  	@menu = menu
  	path = (@menu.post.present?)? @menu.post : @menu.category

  	raw content_tag :li, link_to(@menu.name, path), class: current_active(path)
  end
end
