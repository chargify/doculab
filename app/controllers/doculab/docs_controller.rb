module Doculab
  class DocsController < ApplicationController
    rescue_from Doc::FileNotFound, :with => :handle_file_not_found
    layout 'docs'
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
        @page = TableOfContents.pages.detect { |p| p.permalink == permalink } || TableOfContents::UnindexedPage.new
      end
      
      def handle_file_not_found(e)
        @doc = nil
        @page = TableOfContents::Page.new("File Not Found", nil)
        render :text => e.message, :layout => true
      end
  end
end