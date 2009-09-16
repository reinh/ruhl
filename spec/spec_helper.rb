require File.expand_path(File.join(File.dirname(__FILE__), %w[.. lib ruhl]))

def html(name)
  File.join( File.dirname(__FILE__), 'html', "#{name}.html" )
end

def do_parse(html)
  Nokogiri::HTML(html)
end

def create_doc
  html = Ruhl::Engine.new(@html).render(self)
  do_parse(html)
end
 
