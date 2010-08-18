require 'rubygems'
require 'bundler'

Bundler.setup
Bundler.require
require 'doculab/engine'

module Doculab
  # What are you documenting?
  mattr_accessor :project_name
  
  # Documentation title, used on the index page and in the <title> tag.
  # Default is "#{project_name} Documentation"
  #
  # Set this in your configuration via:
  # 
  #     Doculab.title = "Super Amazing Documentation"
  mattr_writer :title
  def self.title
    @@title ||= [Doculab.project_name, "Documentation"].reject(&:blank?).join(' ')
  end
  
  # Normally, routes for Doculab are set up based off of "root":
  #
  #   http://docs.example.com/          # => Renders the index doc
  #   http://docs.example.com/overview  # => Renders the "overview" doc
  #
  # Setting the route base can put Doculab routes in a "sub-directory":
  #
  #   Doculab.route_base = "my-docs"
  #
  #   http://docs.example.com/my-docs/          # => Renders the index page
  #   http://docs.example.com/my-docs/overview  # => Renders the "overview" doc
  mattr_accessor :route_base
  
  # Define the layout to use for your "main layout", as found in the doculab/layouts directory.
  # Defaults to "docs" (which equates to docs.html.erb)
  mattr_writer :main_layout
  def self.main_layout
    @@main_layout ||= 'docs'
  end
  
  # You may optionally define a separate layout for the index page.  One use for this is to
  # create a richer homepage with search boxes and cool stuff that's harder to do in
  # index.textile.
  #
  # Consider making this "nested layout" as described in
  # http://edgeguides.rubyonrails.org/layouts_and_rendering.html#using-nested-layouts
  mattr_writer :index_layout
  def self.index_layout
    @@index_layout ||= main_layout
  end
end
