$:.unshift File.dirname(__FILE__)

require 'nokogiri'
require 'ruhl/errors'

module Ruhl
  class Engine
    attr_reader :doc, :scope

    def initialize(html)
      @doc = Nokogiri::HTML(html)
    end

    def render(current_scope)
      set_scope(current_scope)

      doc.xpath('//*[@ruby]').each do |tag|
        code = tag['ruby']

        if code =~ /^\w+:/
          process_attribute(tag,code)
        else
          tag.content = execute_ruby(tag,code)
        end

        tag.remove_attribute('ruby')
      end

      doc.to_s
    end

    private

    def process_attribute(tag,code)
      parts = code.split(';')
      parts.each do |pair|
        attribute, value = pair.split(':')

        tag[attribute] = execute_ruby(tag, value.strip)
      end
    end

    def set_scope(current_scope)
      raise Ruhl::NoScopeError unless current_scope
      @scope = current_scope 
    end

    def execute_ruby(tag, code)
      scope.send(code, tag)
    end
  end
end
