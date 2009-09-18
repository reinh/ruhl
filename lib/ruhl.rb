$:.unshift File.dirname(__FILE__)

require 'nokogiri'
require 'ruhl/errors'

module Ruhl
  class Engine
    attr_reader :document, :scope, :layout

    def initialize(html, options = {})
      if @layout = options[:layout]
        raise LayoutNotFoundError.new(@layout) unless File.exists?(@layout)

        @document = Nokogiri::HTML.fragment(html)
      else
        @document = Nokogiri::HTML(html)
      end
    end

    def render(current_scope)
      set_scope(current_scope)

      parse_doc(@document)

      if @layout
        render_with_layout 
      else
        document.to_s
      end
    end

    # The _render_ method is used within a layout to inject
    # the results of the template render.
    #
    # Ruhl::Engine.new(html, :layout => path_to_layout).render(self)
    def _render_
      document.to_s
    end

    private

    def process_attribute(tag,code)
      parts = code.split(';')
      parts.each do |pair|
        attribute, value = pair.split(':')

        tag[attribute] = execute_ruby(tag, value.strip)
      end
    end

    def render_with_layout
     doc = Nokogiri::HTML( File.read(@layout) ) 
     parse_doc(doc)
     doc.to_s
    end

    def parse_doc(doc)
      if (nodes = doc.xpath('//*[@ruby]')).empty?
        nodes = doc.xpath('*[@ruby]')
      end

      nodes.each do |tag|
        code = tag['ruby']

        if code =~ /^\w+:/
          process_attribute(tag,code)
        else
          tag.inner_html = execute_ruby(tag,code)
        end

        tag.remove_attribute('ruby')
      end
    end
      
    def set_scope(current_scope)
      raise Ruhl::NoScopeError unless current_scope
      @scope = current_scope 
    end

    def execute_ruby(tag, code)
      unless code == '_render_'
        scope.send(code, tag)
      else
        _render_
      end
    end
  end
end
