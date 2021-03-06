# Generated by jeweler
# DO NOT EDIT THIS FILE
# Instead, edit Jeweler::Tasks in Rakefile, and run `rake gemspec`
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{ruhl}
  s.version = "0.5.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Andrew Stone"]
  s.date = %q{2009-09-28}
  s.description = %q{Make your HTML dynamic with the addition of a ruby attribute.}
  s.email = %q{andy@stonean.com}
  s.extra_rdoc_files = [
    "README"
  ]
  s.files = [
    ".gitignore",
     "README",
     "Rakefile",
     "VERSION",
     "lib/ruhl.rb",
     "lib/ruhl/errors.rb",
     "lib/ruhl/sinatra.rb",
     "ruhl.gemspec",
     "spec/html/basic.html",
     "spec/html/fragment.html",
     "spec/html/layout.html",
     "spec/html/main_with_sidebar.html",
     "spec/html/medium.html",
     "spec/html/seo.html",
     "spec/html/sidebar.html",
     "spec/rcov.opts",
     "spec/ruhl_spec.rb",
     "spec/spec.opts",
     "spec/spec_helper.rb"
  ]
  s.homepage = %q{http://github.com/stonean/ruhl}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{Ruby Hypertext Language}
  s.test_files = [
    "spec/ruhl_spec.rb",
     "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
