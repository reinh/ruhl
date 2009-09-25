require File.expand_path(File.join(File.dirname(__FILE__), %w[.. lib ruhl]))

def html(name)
  File.join( File.dirname(__FILE__), 'html', "#{name}.html" )
end

def do_parse(html)
  Nokogiri::HTML(html)
end

def create_doc(layout = nil)
  options = {:layout => layout} 
  html = Ruhl::Engine.new(@html, :layout => layout).render(self)
  do_parse(html)
end

class TestUser
  attr_accessor :first_name, :last_name, :email

  def initialize(first, last , email)
    @first_name = first
    @last_name  = last
    @email = email
  end
end
 
