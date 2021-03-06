class Engine < Rails::Engine
  initializer "doculab.add_view_paths", :before => :add_view_paths do |app|
    app.paths["app/views"].unshift Rails.root.join("doculab").to_s
  end
  
  initializer "doculab.table_of_contents_preparation", :before => :add_to_prepare_blocks do |app|
    app.config.to_prepare do
      table_of_contents = Engine.table_of_contents_path
      begin
        load table_of_contents
      rescue LoadError
        Doculab::TableOfContents.define do; end
        if %w(production development).include?(Rails.env)
          Engine.print_warning(:table_of_contents)
        end
      end
    end
  end
  
  def self.table_of_contents_path
    Rails.root.join("doculab", "meta", "table_of_contents.rb").to_s
  end
  
  def self.print_warning(message_key)
    message = case message_key
    when :table_of_contents
      "There is no Table of Contents defined at #{table_of_contents_path}"
    else
      nil
    end
  
    if message.present?
      message = "=> Doculab WARNING: #{message}"
      puts message
      Rails.logger.info message
    end
  end
  
end
