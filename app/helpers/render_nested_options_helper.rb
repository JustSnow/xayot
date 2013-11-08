module RenderNestedOptionsHelper
  class Render
    class << self
      attr_accessor :h, :options

      def render_node(h, options)
        @h, @options = h, options

        node = options[:node]

        # this_node      = options[:selected] == node
        this_node = options[:selected] == node.parent_id
        selected_class = this_node ? ' selected' : nil
        selected       = this_node ? " selected='selected'" : nil

        "
        <option value='#{node[:id]}' class='l_#{ options[:level] }#{selected_class}' #{selected}>#{(node.respond_to?(:content))? node.content.name : node.name}</option>
        #{ options[:children] }
        "
      end

    end
  end
end