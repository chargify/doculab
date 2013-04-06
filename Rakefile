# encoding: UTF-8
require 'rubygems'
require 'bundler'
Bundler.setup(:default, :development)

require 'rake'
require 'rdoc/task'
require 'rubygems/package_task'

require 'rspec/core'
require 'rspec/core/rake_task'

require 'cucumber/rake/task'

require 'jeweler'

# Specs #######################################################################
Rspec::Core::RakeTask.new(:spec)

task :default => :spec

Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'Doculab'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README.rdoc')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

# Cucumber ####################################################################
namespace :cucumber do
  Cucumber::Rake::Task.new(:ok, 'Run features that should pass') do |t|
    t.fork = true # You may get faster startup if you set this to false
    t.profile = 'default'
  end

  Cucumber::Rake::Task.new(:wip, 'Run features that are being worked on') do |t|
    t.fork = true # You may get faster startup if you set this to false
    t.profile = 'wip'
  end

  Cucumber::Rake::Task.new(:rerun, 'Record failing features and run only them if any exist') do |t|
    t.fork = true # You may get faster startup if you set this to false
    t.profile = 'rerun'
  end

  desc 'Run all features'
  task :all => [:ok, :wip]
end
task :cucumber => 'cucumber:ok'
task :features => :cucumber do
  STDERR.puts "*** The 'features' task is deprecated. See rake -T cucumber ***"
end

# Gem #########################################################################

Jeweler::Tasks.new do |gem|
  gem.name = "doculab"
  gem.summary = "A Rails Engine for creating a simple documentation site"
  gem.description = "A Rails Engine for a simple file-based CMS, suitable for a documentation site.  Originally created to power the Chargify documentation at http://docs.chargify.com"
  gem.email = "michael@webadvocate.com"
  gem.homepage = "http://github.com/grasshopperlabs/doculab"
  gem.authors = ["Michael Klett"]
  gem.add_dependency "tilt"
  gem.add_dependency "RedCloth"
  gem.add_development_dependency "rails", ">= 3.0.0.rc"
  gem.add_development_dependency "rspec-rails", ">= 2.0.0.beta"
  gem.add_development_dependency 'jeweler'
  gem.add_development_dependency 'cucumber'
  gem.add_development_dependency 'cucumber-rails'
  gem.add_development_dependency 'capybara'
  # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
end
Jeweler::GemcutterTasks.new
