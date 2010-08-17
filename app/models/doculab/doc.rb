module Doculab
  class Doc
    cattr_reader :valid_attributes
    @@valid_attributes = [:permalink, :file, :title, :content, :section]

    cattr_writer :directory

    attr_accessor *@@valid_attributes

    def initialize(attributes = {})
      attributes.assert_valid_keys(@@valid_attributes)
      attributes.each do |field, value|
        send("#{field}=", value)
      end
    end

    def render
      template = ::Tilt.new(file)
      template.render(self)
    end

    def self.find(permalink)
      file = file_for_permalink(permalink)

      unless file && File.exist?(file)
        raise FileNotFound, "No file found for '#{permalink}'"
      end

      content = File.read(file)
      self.new(:permalink => permalink, :file => file, :content => content)
    end

    def self.directory
      @@directory ||= Rails.root.join('doculab', 'docs')
      Pathname.new(@@directory)
    end

    # Returns an array of filenames for all files in the docs directory
    def self.filenames
      filepaths.collect {|fn| File.basename(fn) }
    end

    def self.filepaths
      Dir.glob(directory.join("*.{#{extensions.join(',')}}"))
    end

    class FileNotFound < StandardError; end

    private

      # Returns an array of available extensions
      def self.extensions
        %w(textile md)
      end

      def self.file_for_permalink(permalink)
        filepaths.detect {|fn| File.basename(fn).split('.').first == permalink }
      end

  end
end