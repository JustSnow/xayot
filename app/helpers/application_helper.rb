module ApplicationHelper
	def current_active path
    'active' if current_page?(path)
  end

  def make_menu_link menu
  	@menu = menu
  	path = (@menu.post.present?)? @menu.post : @menu.category

  	raw content_tag :li, link_to(@menu.name, path), class: current_active(path)
  end

  def created_at_info created_date, klass = 'info'
  	raw tag_label glyph(:calendar) + russian_date(created_date), klass
  end

  def russian_date date
  	Russian::strftime(date, '%e %B в %l:%M %p')
  end
end
