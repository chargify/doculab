module Doculab
  module TableOfContentsHelper
    def page_title
      parts = []
      
      if @page
        parts << @page.title
      end
      
      parts << "Chargify Documentation"
      
      parts.join(" - ")
    end
    
    
    def toc_link(page)
      if page.doc
        link_to page.title, doculab_doc_path(page.permalink), :class => current_page?(page) ? 'current' : nil
      else
        page.title
      end
    end
    
    def page
      @page
    end
    
    private
    
      def current_page?(page)
        page && (page == @page)
      end
  end
end