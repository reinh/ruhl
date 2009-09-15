require 'nokogiri'

class Ruhl
  attr_reader :doc

  def initialize(html)
    @doc = Nokogiri::HTML(html)
  end

  def render(scope)
    raise "No scope defined." unless scope

    doc.xpath('//*[@ruby]').each do |tag|
      code = tag['ruby']
      if scope.respond_to?(code)
        tag.content = scope.send(code)
      elsif ivar = scope.instance_variable_get(code)
        tag.content = ivar.to_html(tag)
      end
    end

    doc
  end
end

