module Doculab
  class DocsController < ApplicationController
    rescue_from Doc::FileNotFound, :with => :handle_file_not_found
    layout :select_layout
    helper TableOfContentsHelper
  
    def index
      find('index')
      render :text => @doc.render, :layout => true
    end
  
    def show
      find(params[:permalink])
      render :text => @doc.render, :layout => true
    end
  
    protected
      def find(permalink)
        @doc = Doc.find(permalink)
        @page = lookup_page(permalink)
      end
      
      def handle_file_not_found(e)
        @doc = Doc.new(:title => "File Not Found", :content => e.message)
        @page = TableOfContents::Page.new("File Not Found")
        render :text => e.message, :layout => true
      end
      
      def lookup_page(permalink)
        if permalink == 'index'
          TableOfContents::Page.new(Doculab.title)
        elsif page = TableOfContents.lookup(permalink)
          page
        else
          TableOfContents::Page.new(permalink.titleize)
        end
      end
      
      def select_layout
        case params[:permalink]
        when 'index', NilClass
          Doculab.index_layout
        else
          Doculab.main_layout
        end
      end
    # end protected
  end
end