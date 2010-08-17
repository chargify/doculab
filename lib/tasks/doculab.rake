namespace :doculab do
  desc "Bootstrap a doculab directory within your project"
  task :bootstrap do
    puts "Hello Bootstrap!"
  end
  
  desc "Generate blank doc files for all pages defined in the Table of Contents which do not yet exist"
  task :skeleton => :environment do
    Doculab::TableOfContents.pages.each do |page|
      unless File.exist?(page.filename)
        FileUtils.touch(page.filename)
      end
    end
  end
end
