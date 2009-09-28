require 'rubygems'
require 'rake'
require 'rcov'
require 'spec/rake/spectask'

task :default => 'rcov'

desc "Run all specs and rcov in a non-sucky way"
Spec::Rake::SpecTask.new(:rcov) do |t|
  t.spec_opts = IO.readlines("spec/spec.opts").map {|l| l.chomp.split " "}.flatten
  t.spec_files = FileList['spec/**/*_spec.rb']
  t.rcov = true
  t.rcov_opts = IO.readlines("spec/rcov.opts").map {|l| l.chomp.split " "}.flatten
end


begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "ruhl"
    gemspec.summary = "Ruby Hypertext Language"
    gemspec.description = "Make your HTML dynamic with the addition of a ruby attribute."
    gemspec.email = "andy@stonean.com"
    gemspec.homepage = "http://github.com/stonean/ruhl"
    gemspec.authors = ["Andrew Stone"]
    gemspec.add_dependency('nokogiri','>=1.3.3')
    gemspec.add_development_dependency('rspec')
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end

