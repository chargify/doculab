module Doculab
  module DocsHelper
    def doc_content
      content_for?(:doc_content) ? yield(:doc_content) : yield
    end
    
    def doc
      @doc
    end
  
    def sections
      Doculab::TableOfContents.sections
    end
  end
end