# encoding: UTF-8
require 'rake'
require 'rake/rdoctask'
require 'rake/gempackagetask'

require 'rspec/core'
require 'rspec/core/rake_task'

require 'cucumber/rake/task'

Rspec::Core::RakeTask.new(:spec)

task :default => :spec

Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'Doculab'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README.rdoc')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

spec = Gem::Specification.new do |s|
  s.name = "doculab"
  s.summary = "Easy documentation"
  s.description = "Easy documentation"
  s.files =  FileList["[A-Z]*", "lib/**/*", "app/**/*", "config/**/*", "features/**/*", "spec/**/*"]
  s.version = "0.0.1"
  s.add_dependency "tilt"
  s.add_dependency "RedCloth"
  s.add_development_dependency "rspec-rails", ">= 2.0.0.beta"
  s.add_development_dependency 'cucumber'
  s.add_development_dependency 'cucumber-rails'
  s.add_development_dependency 'capybara'
end
  
Rake::GemPackageTask.new(spec) do |pkg|
end

desc "Install the gem #{spec.name}-#{spec.version}.gem"
task :install do
  system("gem install pkg/#{spec.name}-#{spec.version}.gem --no-ri --no-rdoc")
end

# Cucumber
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
