module AdminHelper
  def help_published(node, admin = true)
    @node = node

    published_node = (@node.respond_to?(:content))? @node.content.published : @node.published

    pub_class = (published_node)? 'icon-ban-circle' : 'icon-ok-sign'
    pub_action = (published_node)? 'unpublish' : 'publish'
    pub_link = (admin)? [pub_action, :admin, @node] : [pub_action, @node]

    link_to pub_link, {title: pub_action} do
      content_tag :i, '', class: pub_class
    end
  end

  def current_link_remove_ingredient recipe, remove_id
    if remove_id.nil?
      link_to '#', class: 'delete_ingredient' do
        content_tag(:span, content_tag(:i, '', class: 'icon-minus'), class: 'img-polaroid')
      end
    else
      link_to destroy_ri_relationship_admin_recipe_path(remove_id), {class: 'delete_from_bd_ingredient', remote: true, method: :delete, confirm: "Удалить связь ##{remove_id} из базы", title: "Удалить связь ##{remove_id} из базы"} do
        content_tag(:span, content_tag(:i, '', class: 'icon-remove'), class: 'img-polaroid')
      end
    end
  end

  # формирование навигации для навигационного меню админки
  def nav_link_html hash_params
    main_link = link_to hash_params[:all_path] do
      content_tag :span do
        concat content_tag(:i, '', class: hash_params[:icon])
        concat hash_params[:name_link]
      end
    end
    main_link.concat(content_tag(:span, "   "))
    new_link = link_to hash_params[:new_path], {title: hash_params[:title_new]} do
      content_tag :span, content_tag(:i, '', class: 'icon-pencil'), class: 'img-polaroid'
    end

    main_link.concat(new_link)
  end
  # end nav link menu

  # gallery button
  def gallery_btn hash_params
    link_to hash_params[:link_gallery], {class: 'btn btn-warning'} do
      content_tag :span do
        concat content_tag :i, '', class: 'icon-camera'
        concat hash_params[:text_gallery]
      end
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
      content_tag :span do
        concat content_tag :i, '', class: 'icon-plus-sign'
        concat hash_params[:text_new]
      end
    end
  end

  def button_all_item hash_params
    link_to hash_params[:link_all], {class: 'btn btn-info'} do
      content_tag :span do
        concat content_tag :i, '', class: 'icon-globe'
        concat hash_params[:text_all]
      end
    end
  end
  # end buttons

  # формирование ссылки на удаление записи
  def delete_link hash_params
    link_to hash_params[:delete_link], {method: :delete, confirm: hash_params[:message]} do
      content_tag(:span, content_tag(:i, '', class: 'icon-remove'), class: 'img-polaroid')
    end
  end
  #end

  def make_notice notice
    content_tag(:div, raw(notice + link_to(content_tag(:i, '', class: 'icon-remove'), '#', class: 'close')), class: 'alert alert-success') if notice.present?
  end

  def make_alert alert
    content_tag(:div, raw(alert + link_to(content_tag(:i, '', class: 'icon-remove'), '#', class: 'close')), class: 'alert alert-error') if alert.present?
  end

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
end