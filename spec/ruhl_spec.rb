require File.join(File.dirname(__FILE__), 'spec_helper')

def generate_h1(tag = nil)
  "data from presenter"     
end

def data_from_method(tag = nil)
  "I am data from a method"
end

def generate_title(tag = nil)
  "I am a custom title"
end

def generate_keywords(tag = nil)
  "I, am, custom, keywords"
end

describe Ruhl do

  describe "basic.html" do
    before do
      @html = File.read html(:basic) 
    end

    it "content of p should be content from data_from_method" do
       doc = create_doc
       doc.xpath('//h1').first.content.should == generate_h1
    end
  end

  describe "seo.html" do
    before do
      @html = File.read html(:seo)
    end

    it "metaDescription should be replaced" do
      doc = create_doc
    end
  end
end



