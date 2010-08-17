module Doculab
  module DocsHelper
    def doc
      @doc
    end
  
    def sections
      Doculab::TableOfContents.sections
    end
  end
end