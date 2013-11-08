# DOC:
# We use Helper Methods for tree building,
# because it's faster than View Templates and Partials

# SECURITY note
# Prepare your data on server side for rendering
# or use h.html_escape(node.content)
# for escape potentially dangerous content
module RenderSortableTreeHelper
  module Render 
    class << self
      attr_accessor :h, :options

      def render_node(h, options)
        @h, @options = h, options

        node = options[:node]

        "
          <li id='#{ node.id }_#{ options[:klass] }'>
            <div class='item'>
              <i class='handle'></i>
              #{ show_link }
              #{ controls }
            </div>
            #{ children }
          </li>
        "
      end

      def show_link
        node = options[:node]
        ns   = options[:namespace]
        url  = h.url_for(ns + [node])
        # title_field = options[:title]
        title_field = (node.respond_to?(:content))? node.content.name : node.name
        edit_path = h.url_for(:controller => options[:klass].pluralize, :action => :edit, :id => node)

        # "<h4>#{ h.link_to(node.send(title_field), url) }</h4>"
        "<h4>#{ h.link_to(title_field, edit_path) }</h4>"

      end

      def controls
        node = options[:node]

        edit_path = h.url_for(:controller => options[:klass].pluralize, :action => :edit, :id => node)
        show_path = h.url_for(:controller => options[:klass].pluralize, :action => :show, :id => node)

        node_pub = (node.respond_to?(:content))? node.content.published : node.published
        pub_class = (node_pub)? 'icon-ban-circle' : 'icon-ok-sign'
        pub_action = (node_pub)? 'unpublish' : 'publish'
        published_path = h.url_for(controller: options[:klass].pluralize, action: pub_action, id: node)

        "
          <div class='controls'>
            <a href='#{published_path}' title='#{pub_action}'><i class='#{pub_class}'></i></a>
            #{ h.link_to '', edit_path, :class => :edit }
            #{ h.link_to '', show_path, :class => :delete, :method => :delete, :data => { :confirm => 'Are you sure?' } }
          </div>
        "
      end

      def children
        unless options[:children].blank?
          "<ol class='nested_set'>#{ options[:children] }</ol>"
        end
      end

    end
  end
end