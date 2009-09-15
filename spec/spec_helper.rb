require File.expand_path(File.join(File.dirname(__FILE__), %w[.. lib ruhl]))


def html(name)
  File.join( File.dirname(__FILE__), 'html', "#{name}.html" )
end

