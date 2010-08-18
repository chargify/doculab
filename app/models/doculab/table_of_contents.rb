module Doculab
  module TableOfContents
    mattr_reader :sections
    mattr_reader :pages

    def self.define(&block)
      @@sections = []
      @@pages = []
      self.instance_eval(&block)
      return self
    end

    def self.section(title, &block)
      section = Section.new(title)
      @@sections << section
      section.build(block)
    end
    
    def self.add_page(page)
      @@pages << page
    end
    
    def self.lookup(permalink)
      pages.detect { |p| p.permalink == permalink }
    end
    
    class Section
      attr_reader :title, :pages
      
      def initialize(title)
        @title = title
        @pages = []
      end
      
      def build(block)
        instance_eval(&block)
      end
      
      def page(title, options = {})
        add_page(Page.new(title, self, options))
      end
      
      private
      
        def add_page(page)
          @pages << page
          TableOfContents.add_page(page)
        end
        
    end
    
    class Page
      attr_reader :parent, :title, :permalink, :doc
      
      def initialize(title, parent = nil, options = {})
        @parent = parent
        @title = title
        @permalink = options[:permalink] || title.parameterize
        @doc = begin
          Doc.find(permalink)
        rescue
          nil
        end
      end
      
      def filename(extension = "textile")
        Doc.directory.join("#{permalink}.#{extension}")
      end
      
      def next_page
        return nil if index.nil?
        TableOfContents.pages[index+1]
      end
      
      def previous_page
        fetch_index = (index || 0)-1
        return nil if fetch_index < 0
        TableOfContents.pages[fetch_index]
      end
      
      private
      
        def index
          TableOfContents.pages.index(self)
        end
    end
  end
end