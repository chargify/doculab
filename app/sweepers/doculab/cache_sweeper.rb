module Doculab
  class CacheSweeper

    def self.sweep!
      File.delete(*cached_file_list)
    end
  
    private

      def self.cached_file_list
        list = Dir.glob(File.join(Rails.public_path, "**", "*.html"))
        list.reject {|file| File.basename(file) =~ /^\d{3}.html$/ }
      end
    
    # end private
  end
end