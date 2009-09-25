$:.unshift File.dirname(__FILE__)

require 'nokogiri'
require 'ruhl/errors'

module Ruhl
  class Engine
    attr_reader :document, :scope, :layout, :local_object

    def initialize(html, options = {})
      @local_object = options[:local_object]

      if @layout = options[:layout]
        raise LayoutNotFoundError.new(@layout) unless File.exists?(@layout)
      end

      if @layout || @local_object
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
        
        value.strip!

        if attribute  == "_partial"
          tag.inner_html = render_partial(tag, value)
        elsif attribute  == "_collection"
          doc = render_collection(tag, value)
          tag.inner_html =  doc
        else
          tag[attribute] = execute_ruby(tag, value)
        end
      end
    end

    def render_with_layout
      render_file( File.read(@layout) ) 
    end

    def render_partial(tag, code)
      file = execute_ruby(tag, code)
      raise PartialNotFoundError.new(file) unless File.exists?(file)
      render_file( File.read(file) )
    end

    def render_collection(tag, code)
      results = execute_ruby(tag, code)
      results.collect do |item|
        Ruhl::Engine.new(tag.inner_html, :local_object => item).render(scope)
      end.to_s
    end

    def render_file(contents)
     doc = Nokogiri::HTML( contents ) 
     parse_doc(doc)
     doc.to_s
    end

    def parse_doc(doc)
      if (nodes = doc.xpath('//*[@ruby]')).empty?
        nodes = doc.search('*[@ruby]')
      end

      #TODO: this feels inefficient...need to rethink
      nodes.each do |tag|
        code = tag['ruby']

        if code =~ /^\w+:/
          process_attribute(tag,code)
        else
          tag.inner_html = execute_ruby(tag,code)
        end

        tag.remove_attribute('ruby')

        # We are changing the NodeSet, stop and reparse
        parse_doc(doc)
        break;
      end
    end
      
    def set_scope(current_scope)
      raise Ruhl::NoScopeError unless current_scope
      @scope = current_scope 
    end

    def execute_ruby(tag, code)
      unless code == '_render_'
        if local_object && local_object.respond_to?(code)
          local_object.send(code)
        else
          scope.send(code, tag)
        end
      else
        _render_
      end
    end
  end
end
