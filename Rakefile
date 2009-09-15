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
