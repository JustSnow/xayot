module AdminHelper
  ALERT_TYPES = [:error, :info, :success, :warning]

  def help_published(node, admin = true)
    @node = node

    published_node = (@node.respond_to?(:content))? @node.content.published : @node.published
    pub_action = (published_node)? 'unpublish' : 'publish'
    pub_link = (admin)? [pub_action, :admin, @node] : [pub_action, @node]

    link_to glyph((published_node)? 'ban-circle' : 'ok-sign'), pub_link, {title: pub_action}
  end

  # формирование навигации для навигационного меню админки
  def nav_link_html hash_params
    main_link = link_to content_tag(
      :span, 
      raw(
        glyph(hash_params[:icon]) + 
        hash_params[:name_link])
      ), 
      hash_params[:all_path]

    main_link.concat(content_tag(:span, "   "))
    new_link = link_to content_tag(
      :span, 
      glyph(:pencil), 
      class: 'img-polaroid'
      ), hash_params[:new_path], {title: hash_params[:title_new]}

    main_link.concat(new_link)
  end
  # end nav link menu

  # gallery button
  def gallery_btn hash_params
    link_to hash_params[:link_gallery], {class: 'btn btn-warning'} do
      content_tag :span, raw(glyph(:camera) + hash_params[:text_gallery])
    end
  end

  # формирование кнопок навигации для админки
  def button_item hash_params
    if current_page?(action: 'new')
      button_all_item(hash_params)
    else
      button_all_item(hash_params).concat(button_new_item(hash_params))
    end
  end

  def button_new_item hash_params
    link_to hash_params[:link_new], {class: 'btn btn-success'} do
      content_tag :span, raw(glyph('plus-sign') + hash_params[:text_new])
    end
  end

  def button_all_item hash_params
    link_to hash_params[:link_all], {class: 'btn btn-info'} do
      content_tag :span, raw(glyph(:globe) + hash_params[:text_all])
    end
  end
  # end buttons

  # формирование ссылки на удаление записи
  def delete_link hash_params
    link_to hash_params[:delete_link], {method: :delete, confirm: hash_params[:message]} do
      content_tag(:span, glyph(:remove), class: 'img-polaroid')
    end
  end
  #end

  def make_table_main_admin node, head
    head_table = content_tag(:tr, content_tag(:th, head))
    
    content_tag :table, class: 'table table-bordered' do
      concat head_table
      node.each do |n|
        node_name = (n.respond_to?(:content))? n.content.name : n.name
        concat content_tag(:tr, content_tag(:td, link_to(node_name, [:edit, :admin, n])))
      end
    end
  end

  def make_link_join_product product_node
    l = []
    product_node.each { |node| l << link_to(node.name, [:edit, :admin, node]) }
    raw l.join(', ')
  end

  def options_for_select_menu node
    @node = node
    raw options_for_select(@node.map {|n| [(n.respond_to?(:content))? n.content.name : n.name, n.id]})
  end

  # bootstrap
  def bootstrap_flash
    flash_messages = []
    flash.each do |type, message|
      # Skip empty messages, e.g. for devise messages set to nothing in a locale file.
      next if message.blank?
      
      type = :success if type == :notice
      type = :error   if type == :alert
      next unless ALERT_TYPES.include?(type)

      Array(message).each do |msg|
        text = content_tag(:div,
                content_tag(:button, raw("&times;"), class: "close", "data-dismiss" => "alert") +
                msg.html_safe, class: "alert fade in alert-#{type}")
        flash_messages << text if msg
      end
    end
    flash_messages.join("\n").html_safe
  end

  # ==== Examples
  # glyph(:share_alt)
  # # => <i class="icon-share-alt"></i>
  # glyph(:lock, :white)
  # # => <i class="icon-lock icon-white"></i>
  # glyph(:thumbs_up, :pull_left)
  # # => <i class="icon-thumbs-up pull-left"></i>

  def glyph(*names)
    names.map! { |name| name.to_s.gsub('_','-') }
    names.map! do |name|
      name =~ /pull-(?:left|right)/ ? name : "icon-#{name}"
    end
    content_tag :i, nil, class: names
  end

  # badge(12, :warning)
  # => <span class="badge badge-warning">12</span>
  def badge(*args)
    badge_label(:badge, *args)
  end

  def tag_label(*args)
    badge_label(:label, *args)
  end

  private
    def badge_label(what, value, type = nil)
      klass = [what]
      klass << "#{what}-#{type}" if type.present?
      content_tag :span, value, :class => "#{klass.join(' ')}"
    end
end